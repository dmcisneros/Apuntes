https://engineering.riotgames.com/news/docker-jenkins-data-persists

<div class="o-layout__item o-layout__item--content c-content">

                




<article role="article" class="c-excerpt">

    <header class="c-header c-header--post c-header--infinite" role="banner">

        
                            <img src="/sites/default/files/articles/19/pngdockerjenkins.png" alt="" class="c-header__image">
            
        
        <time datetime="2015-09-08T08:27:06" class="c-header__date">
            Sep 8, 2015        </time>

    </header><!-- /.c-header -->

    <h1 class="c-excerpt__title">

                    Docker &amp; Jenkins: Data that Persists        
    </h1>

    <div class="field field-name-body field-type-text-with-summary field-label-hidden"><div class="field-items"><div class="field-item even" property="content:encoded"><p dir="ltr">In the <a href="http://engineering.riotgames.com/news/putting-jenkins-docker-container" target="_blank">last blog post</a> we discussed taking more control of our Jenkins Docker image by wrapping the Cloudbees image with our own Dockerfile. This empowered us to set some basic defaults that we previously passed in every time we ran `<em>docker run</em>`.&nbsp;We also took the opportunity to define where to place Jenkins logs and how to use Docker exec to poke around our running container.</p>
<p dir="ltr">We left off with my thoughts that we still needed some kind of data persistence to really make this useful. Containers—and their data—are ephemeral, so we’re still losing all of our Jenkins plugin and job data every time we restart the container. The Cloudbees documentation even tells us that we’re going to need to use volumes to preserve data. They recommend a quick way to store data on your Docker Host, outside of your running containers, by mounting a local host folder. This is a&nbsp;traditional method of&nbsp;persisting information that requires your Dockerhost to be a mount point.</p>
<p dir="ltr">There is another way,&nbsp;however, and that’s to use a Docker <em>data volume</em> to containerize your storage. You can read up about Data Volumes in Dockers documentation <a href="https://docs.docker.com/userguide/dockervolumes/">here</a>.</p>
<p dir="ltr">In this blog post we’ll cover the following subjects:</p>
<ul><li>Persisting Docker data&nbsp;with volumes</li>
<li>Making a data volume container</li>
<li>Sharing data in volumes with other containers</li>
<li>Preserving Jenkins job and plugin</li>
</ul><h2><strong>Host Mounted Volumes vs Data Volume Containers</strong></h2>
<p>When I refer to a “Host Mounted Volume” I am referencing the idea that your Docker host machine stores the data in its file system and when you start a container with `<em>docker run</em>`&nbsp;Docker mounts&nbsp;that physical storage into the container.</p>
<p>This approach has many advantages, the most obvious one being its ease of use. In more complex environments, your data could actually be network or serially attached storage, giving you a lot of space and performance.</p>
<p>It also has a drawback—it requires that you pre-configure the mount point on your Dockerhost. This eliminates two of Docker’s bigger advantages, namely container portability and applications that can “run anywhere.”&nbsp;If you want a truly portable Docker container that can run on any host, you can’t have any expectations of how that host is configured when you make your `<em>docker run</em>`&nbsp;call.</p>
<p>This is where data volumes can help. A data volume is essentially a Docker image that defines storage space. The container itself just defines a place inside Docker's&nbsp;virtual file system where data is stored. The container doesn’t run a process and in fact “stops” immediately after `<em>docker run</em>`&nbsp;is called—as the container exists in a stopped state, so too does its data.</p>
<p>This method allows Docker containers to share data without the requirement that the host be configured with a proper mount point. Users can interact with the containers via Docker commands and never need to touch the host.</p>
<p>There are drawbacks. Performance is a tad slower as you’re maintaining data through Docker’s virtualized file system, so it may not be ideal for applications that need the very best in I/O performance. For most apps, however, this won’t be noticeable. Complexity is also increased as your application now has a minimum of two images (meaning two Dockerfiles)—one for the app&nbsp;and one for storage.</p>
<p>To be clear, either approach is 100% valid and really depends on how exactly you want to work. My own opinion is that applications should be as independent as possible and for the purposes of this article I’ll be showing how to use data volume containers.</p>
<h2>Getting Started</h2>
<p>We’ll start with the Dockerfile we ended up with from <a href="http://engineering.riotgames.com/news/putting-jenkins-docker-container" target="_blank">the last blog post</a>. For reference here it is:</p>
<pre><code class="language-dockerfile hljs"><span class="hljs-built_in">FROM</span> jenkins:<span class="hljs-number">1.609</span>.<span class="hljs-number">1</span>
<span class="hljs-built_in">MAINTAINER</span> Maxfield Stewart

<span class="hljs-built_in">USER</span> root
<span class="hljs-built_in">RUN</span> <span class="bash">mkdir /var/<span class="hljs-built_in">log</span>/jenkins
</span><span class="hljs-built_in">RUN</span> <span class="bash">chown -R jenkins:jenkins /var/<span class="hljs-built_in">log</span>/jenkins
</span><span class="hljs-built_in">USER</span> jenkins

<span class="hljs-built_in">ENV</span> JAVA_OPTS=<span class="hljs-string">"-Xmx8192m"</span>
<span class="hljs-built_in">ENV</span> JENKINS_OPTS=<span class="hljs-string">"--handlerCountStartup=100 --handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log"</span></code></pre><p dir="ltr">For starters, let’s create an image&nbsp;that will just host our log files. This will be an app with two Dockerfiles. We could do this in one root directory but I like to have each Dockerfile inside it’s own directory:</p>
<pre><code class="language-bash hljs">mkdir jenkins-master
mkdir jenkins-data</code></pre><p>Place our original Jenkins Dockerfile inside jenkins-master:</p>
<pre><code class="language-bash hljs">mv Dockerfile jenkins-master</code></pre><p dir="ltr">​To be sure it still works, let’s build the jenkins-master Dockerfile:</p>
<pre><code class="language-bash hljs">docker build -t myjenkins jenkins-master/.</code></pre><p dir="ltr"><img alt="" src="/sites/default/files/tutorial3_step1.gif" style="display:block; height:275px; margin-left:auto; margin-right:auto; width:704px"></p>
<p dir="ltr">Note how you can use the Dockerfile from a folder by providing the relative path. This will be useful later when managing multiple Dockerfiles inside a single root directory. Now let’s create a new Dockerfile in jenkins-data:</p>
<ol><li>Use your favorite editor to create the file “Dockerfile” inside the “jenkins-data” directory</li>
<li>Add the following lines at the top:
<ul><li>
<pre><code class="language-bash hljs">FROM debian:jessie
MAINTAINER yourname</code></pre></li>
<li><strong>NOTE</strong>: I use the base Debian image because it matches the same base image the <a href="https://hub.docker.com/_/jenkins/">Cloudbees Jenkins image</a> uses. Because we’ll be sharing file systems and UID’s across containers we need to match the operating systems.</li>
</ul></li>
<li>Now create the Jenkins user in this container by adding:
<ul><li>
<pre><code class="language-bash hljs">RUN useradd <span class="hljs-operator">-d</span> <span class="hljs-string">"/var/jenkins_home"</span> -u <span class="hljs-number">1000</span> -m <span class="hljs-operator">-s</span> /bin/bash jenkins</code></pre></li>
<li><strong>NOTE</strong>: we set the UID here to the same one the Cloudbees Jenkins image uses so we can match UIDs across containers, which is essential if you want to preserve file permissions between the containers. We also use the same home directory and bash settings.</li>
</ul></li>
<li>We need to recreate the Jenkins log directory in this image because it'll be the new foundation, so add the following lines:
<ul><li>
<pre><code class="language-bash hljs">RUN mkdir -p /var/<span class="hljs-built_in">log</span>/jenkins
RUN chown -R jenkins:jenkins /var/<span class="hljs-built_in">log</span>/jenkins</code></pre></li>
</ul></li>
<li>Now we can add the Docker volume magic. Let’s make the log folder a mount:
<ul><li>
<pre><code class="language-bash hljs">VOLUME [<span class="hljs-string">"/var/log/jenkins"</span>]</code></pre></li>
</ul></li>
<li>Let’s set the user of this container to “jenkins” for consistency, so add:
<ul><li>
<pre><code class="language-bash hljs">USER jenkins</code></pre></li>
</ul></li>
<li>Lastly, while these images don’t actually “run” anything, I like to have them output a message when they start as a reminder to their purpose, so toss in the final line:
<ul><li>
<pre><code class="language-bash hljs">CMD [<span class="hljs-string">"echo"</span>, <span class="hljs-string">"Data container for Jenkins"</span>]</code></pre></li>
</ul></li>
</ol><p>That should do it! For reference here’s the entire new Dockerfile in one shot:</p>
<pre><code class="language-dockerfile hljs"><span class="hljs-built_in">FROM</span> debian:jessie
<span class="hljs-built_in">MAINTAINER</span> yourname

<span class="hljs-built_in">RUN</span> <span class="bash">useradd <span class="hljs-operator">-d</span> <span class="hljs-string">"/var/jenkins_home"</span> -u <span class="hljs-number">1000</span> -m <span class="hljs-operator">-s</span> /bin/bash jenkins
</span><span class="hljs-built_in">RUN</span> <span class="bash">mkdir -p /var/<span class="hljs-built_in">log</span>/jenkins
</span><span class="hljs-built_in">RUN</span> <span class="bash">chown -R jenkins:jenkins /var/<span class="hljs-built_in">log</span>/jenkins
</span>
<span class="hljs-built_in">VOLUME</span> <span class="bash">[<span class="hljs-string">"/var/log/jenkins"</span>]
</span>
<span class="hljs-built_in">USER</span> jenkins

<span class="hljs-built_in">CMD</span> <span class="bash">[<span class="hljs-string">"echo"</span>, <span class="hljs-string">"Data container for Jenkins"</span>]</span></code></pre><p>Go ahead and save the file then build it:</p>
<pre><code class="language-bash hljs">docker build -t myjenkinsdata jenkins-data/.</code></pre><p dir="ltr">Your base image now exists for your Jenkins data volume. However, we need to adapt our existing image to make use of it!</p>
<p dir="ltr"><img alt="" src="/sites/default/files/tutorial3_step2.gif" style="display:block; height:275px; margin-left:auto; margin-right:auto; width:704px"></p>
<h2><strong>Preparing the Data Volume</strong></h2>
<p>First let’s go ahead and start the new data volume.</p>
<pre><code class="language-bash hljs">docker run --name=jenkins-data myjenkinsdata</code></pre><p dir="ltr">You’ll&nbsp;note that you get the output message we added to the CMD file. If you run:</p>
<pre><code class="language-bash hljs">docker ps</code></pre><p dir="ltr">You’ll see that there are&nbsp;no running containers. And if you run</p>
<pre><code class="language-bash hljs">docker ps <span class="hljs-operator">-a</span></code></pre><p dir="ltr">You should see our new data container stopped. That’s okay: this is how data volume containers work. So long as that container is there, your data in <em>/var/log/jenkins</em> will be preserved because we defined that as a volume point. With it in place, we can now instruct our Jenkins (master) container to use it and be able to preserve our logs even if we remove our Jenkins (master) container.</p>
<p dir="ltr"><img alt="" src="/sites/default/files/tutorial3_step3_0.gif" style="display:block; height:278px; margin-left:auto; margin-right:auto; width:705px"></p>
<h2><strong>Using the Data&nbsp;Volume</strong></h2>
<p>This part is easy. All the hard work went into setting up the data volume. To make use of it we just need to add the “volumes-from” directive to our `<em>docker run</em>` call like so:</p>
<pre><code class="language-bash hljs">docker run -p <span class="hljs-number">8080</span>:<span class="hljs-number">8080</span> -p <span class="hljs-number">50000</span>:<span class="hljs-number">50000</span> --name=jenkins-master --volumes-from=jenkins-data <span class="hljs-operator">-d</span> myjenkins</code></pre><blockquote>
<p dir="ltr"><em>You'll can see above that I've added a new port mapping, for port 50000. This is to handle connections from JNLP based build slaves. I'll talk about this more in a future blog post but wanted to include it here in case you start using this as the basis for your own Jenkins server.</em></p>
</blockquote>
<p dir="ltr">Note that we just used the handy “jenkins-data” name we gave the container. Docker is smart enough to reference those names. You can verify everything still works by tailing the log file again:</p>
<pre><code class="language-bash hljs">docker <span class="hljs-built_in">exec</span> jenkins-master tail <span class="hljs-operator">-f</span> /var/<span class="hljs-built_in">log</span>/jenkins/jenkins.log</code></pre><p dir="ltr"><img alt="" src="/sites/default/files/tutorial3_step4.gif" style="display:block; height:275px; margin-left:auto; margin-right:auto; width:704px"></p>
<p dir="ltr">But how do we know the volume mount works? Easy, because by default Jenkins appends to its log file—a simple start/clean/restart can prove it:</p>
<pre><code class="language-dockerfile hljs">docker stop jenkins-master
docker rm jenkins-master
docker <span class="hljs-built_ins">run</span> -p 8080:8080 -p 50000:50000 --name=jenkins-master --volumes-<span class="hljs-built_ins">from</span>=jenkins-data -d myjenkins
docker exec jenkins-master cat /var/log/jenkins/jenkins.log</code></pre><p dir="ltr">You should see the first, then second Jenkins startup messages in the log. Jenkins can now crash, or be upgraded, and we’ll always have the old log. Of course this means you have to cleanup that log and log directory as you see fit just like you would on a regular Jenkins host.</p>
<p dir="ltr"><img alt="" src="/sites/default/files/tutorial3_step5.gif" style="display:block; height:275px; margin-left:auto; margin-right:auto; width:704px"></p>
<p dir="ltr">Don’t forget about <em>docker cp</em>. You can just copy the log file out of the data volume container even if you lose the master container:</p>
<pre><code class="language-bash hljs">docker cp jenkins-data:/var/<span class="hljs-built_in">log</span>/jenkins/jenkins.log jenkins.log</code></pre><p dir="ltr">Preserving log data is just a minor advantage—we really did this to be able to save key Jenkins data, like plugins and jobs, between container restarts. Using the log file was a good way to demonstrate how things were working simply.</p>
<h2><strong>Saving Jenkins Home Dir</strong></h2>
<p>First, let’s add the Jenkins Home directory to the data volume. Edit the Dockerfile in&nbsp;jenkins-data/Dockerfile and update the VOLUME command:</p>
<pre><code class="language-bash hljs">VOLUME [<span class="hljs-string">"/var/log/jenkins"</span>, <span class="hljs-string">"/var/jenkins_home"</span>]</code></pre><p dir="ltr">Because the folder is already owned and created by the Jenkins user we don’t need to do anything except add it as a container mount point. Don’t forget to rebuild your new data image and cleanup the old one before restarting it:</p>
<pre><code class="language-bash hljs">docker rm jenkins-data
docker build -t myjenkinsdata jenkins-data/.
docker run --name=jenkins-data myjenkinsdata</code></pre><p dir="ltr"><img alt="" src="/sites/default/files/tutorial3_step6.gif" style="display:block; height:275px; margin-left:auto; margin-right:auto; width:704px"></p>
<p dir="ltr">Before we use this though, there’s one annoyance with the default Cloudbee’s Docker image. By default, it stores the uncompressed Jenkins war file in jenkins_home, which means we’d preserve this data between Jenkins runs. This is not ideal as we don’t need to save this data and it could cause confusion when moving between Jenkins versions. So let’s use another Jenkins startup option to move it to <em>/var/cache/jenkins</em>.</p>
<p>Edit the Jenkins-Master Dockerfile and update the JENKINS_OPTS line to:</p>
<pre><code class="language-bash hljs">ENV JENKINS_OPTS=<span class="hljs-string">"--handlerCountStartup=100 --handlerCountMax=300 --logfile=/var/log/jenkins/jenkins.log --webroot=/var/cache/jenkins/war"</span></code></pre><p dir="ltr">This sets the Jenkins webroot. However, we now need to make sure this directory exists and is permissioned to the Jenkins user, so update the section where we create the log directory to look like this:</p>
<pre><code class="language-dockerfile hljs"><span class="hljs-built_in">USER</span> root
<span class="hljs-built_in">RUN</span> <span class="bash">mkdir /var/<span class="hljs-built_in">log</span>/jenkins
</span><span class="hljs-built_in">RUN</span> <span class="bash">mkdir /var/cache/jenkins
</span><span class="hljs-built_in">RUN</span> <span class="bash">chown -R jenkins:jenkins /var/<span class="hljs-built_in">log</span>/jenkins
</span><span class="hljs-built_in">RUN</span> <span class="bash">chown -R jenkins:jenkins /var/cache/jenkins
</span><span class="hljs-built_in">USER</span> jenkins</code></pre><p dir="ltr">Save your Dockerfile, rebuild your jenkins-master image, and restart it. Please note the use of “rm -v” below. Now that we’re playing with volumes, we need to remove the data volumes when we’re done using them. Docker doesn’t clean them up by default because you might want to keep them in case of emergency.</p>
<pre><code class="language-dockerfile hljs">docker stop jenkins-master
docker rm -v jenkins-master
docker build -t myjenkins jenkins-master/.
docker <span class="hljs-built_ins">run</span> -p 8080:8080 -p 50000:50000 --name=jenkins-master --volumes-<span class="hljs-built_ins">from</span>=jenkins-data -d myjenkins</code></pre><p dir="ltr">Your container should start. You can confirm we effectively moved the WAR file correctly by running the following command:</p>
<pre><code class="language-bash hljs">docker <span class="hljs-built_in">exec</span> jenkins-master ls /var/cache/jenkins/war</code></pre><p dir="ltr">You should see the uncompressed contents there. But how do we know this fancy new layout saves Jenkins data?</p>
<p dir="ltr"><img alt="" src="/sites/default/files/tutorial3_step7.gif" style="display:block; height:278px; margin-left:auto; margin-right:auto; width:705px"></p>
<h2><strong>Testing You Can Keep Jobs Between Runs</strong></h2>
<p>We can perform this test easily. With your jenkins-master container running, let’s go make a new Jenkins build job!</p>
<ol><li>Point your browser to: <u><a href="http://localhost:8080" style="text-decoration:none;">http://yourdockermachineip:8080</a></u> (grab with 'docker-machine ip default')</li>
<li>Create a new job by clicking: “New Item”</li>
<li>Enter: “testjob” for the item name</li>
<li>Choose: Freestyle software project</li>
<li>Click “ok”</li>
<li>Click “save”</li>
</ol><p><img alt="" src="/sites/default/files/Screen%20Shot%202015-09-08%20at%201.02.39%20PM.png" style="display:block; height:187px; margin-left:auto; margin-right:auto; width:740px"></p>
<p>Our “useless for anything but testing” new job should show up on the master job list. Now stop and remove your Jenkins container.</p>
<pre><code class="language-bash hljs">docker stop jenkins-master
docker rm jenkins-master</code></pre><blockquote>
<p dir="ltr">Notice that we correctly didn't use "-v" here. We only want to use "-v" when we want to totally remove the data volume. &nbsp;Remember, data volumes work like pointers. What Docker is actually doing is creating a virtual file system on disk—as&nbsp;long as one currently defined container&nbsp;references it, it will exist. &nbsp;When jenkins-master is removed here, the jenkins-data volume still references the virtual file system. If we were to use "-v" here, Docker would take that as an override and delete that&nbsp;virtual file system.&nbsp;This&nbsp;would break the reference jenkins-data has to it, and things would get very ugly. &nbsp;</p>
</blockquote>
<p dir="ltr">In the old image we had, this would’ve also deleted our job. When we recreate the container however:</p>
<ol><li>
<pre><code class="language-bash hljs">docker run -p <span class="hljs-number">8080</span>:<span class="hljs-number">8080</span> -p <span class="hljs-number">50000</span>:<span class="hljs-number">50000</span> --name=jenkins-master --volumes-from=jenkins-data <span class="hljs-operator">-d</span> myjenkins</code></pre></li>
<li>Refresh your browser at&nbsp;<a href="http://localhost:8080" style="text-decoration:none;"><u>http://yourdockermachineip:8080</u></a> and wait for Jenkins to start</li>
</ol><p>We’ll find our test job is still there. Mission accomplished!</p>
<h2><strong>Conclusion</strong></h2>
<p>As with the previous blog posts, you can find updates and example files from this post on my <a href="https://github.com/maxfields2000/dockerJenkins_tutorial/tree/master/tutorial_03">Github repository</a>. You’ll note the makefile has once again been updated and includes a new “clean-data” command if you want to wipe out your data container intentionally.</p>
<p>At this point we have a fully functioning Jenkins image. We can save our logs, jobs, and plugins because we placed jenkins_home in a data volume container so it persists between container runs. As a side bonus, it will even persist if the Docker daemon crashes, or the host restarts, because Docker preserves stopped containers.</p>
<p>While we could just start using this set up, in practice there are still some things that could stand to be improved. Here’s the short list:</p>
<ul><li>We’d like to proxy a web server like NGINX in front of our Jenkins container.</li>
<li>Managing multiple images and containers is starting to get annoying, even with a makefile. Is there an easier way?</li>
<li>We need a way to backup our Jenkins environment, especially jobs.</li>
<li>What if we don’t want to use Debian as our base OS? What if we don’t like relying on external images?</li>
<li>We haven’t done anything about build slaves. While this set up will allow any standard slave to connect, wouldn’t it be awesome if we could set up build slaves as Docker containers?</li>
</ul><p>Each one of these is basically its own blog post. Up next we’re going to get a web proxy set up and after that discuss dealing with having three containers: that means introducing Docker Compose. The other subjects such as build environments in containers, changing our base OS, and backing up Jenkins will be further out. Stay tuned!</p>
<ol></ol></div></div></div>
    <div class="c-excerpt-meta c-excerpt-meta--post">

        <div class="c-excerpt-meta__group">

            
            <span class="c-excerpt-meta__author">Posted by Maxfield F Stewart</span>

            <ul class="o-list-inline c-excerpt-meta__social">
                <li class="c-social__item c-excerpt-meta__item">
                    <a href="mailto:?subject=From the Riot Games Techblog: Docker &amp; Jenkins: Data that Persists&amp;body=https://engineering.riotgames.com/news/docker-jenkins-data-persists" class="c-social__link c-social__link--mail-alt c-excerpt-meta__link">
                        <i class="c-icon c-icon--mail-alt"></i>
                    </a>
                </li>
                <li class="c-social__item c-excerpt-meta__item">
                    <a href="" class="c-social__link c-social__link--facebook c-excerpt-meta__link js-share" data-target="facebook" data-title="Docker &amp; Jenkins: Data that Persists" data-desc="http://riot.com/1goYCmo #RiotTechBlog" data-image="https://engineering.riotgames.com/sites/default/files/articles/19/pngdockerjenkins.png" data-url="https://engineering.riotgames.com/news/docker-jenkins-data-persists">
                        <i class="c-icon c-icon--facebook"></i>
                    </a>
                </li>
                <li class="c-social__item c-excerpt-meta__item">
                    <a href="" class="c-social__link c-social__link--twitter c-excerpt-meta__link js-share" data-target="twitter" data-title="Docker &amp; Jenkins: Data that Persists http://riot.com/1goYCmo via @RiotCareers #RiotTechBlog" data-url="https://engineering.riotgames.com/news/docker-jenkins-data-persists">
                        <i class="c-icon c-icon--twitter"></i>
                    </a>
                </li>
                <li class="c-social__item c-excerpt-meta__item">
                    <a href="" class="c-social__link c-social__link--linkedin c-excerpt-meta__link js-share" data-target="linkedin" data-title="Docker &amp; Jenkins: Data that Persists" data-desc="http://riot.com/1goYCmo #RiotTechBlog" data-url="https://engineering.riotgames.com/news/docker-jenkins-data-persists">
                        <i class="c-icon c-icon--linkedin"></i>
                    </a>
                </li>
            </ul>

        </div>

    </div>

    <hr class="c-rule c-rule--content">

    
        <div class="c-discuss js-discuss">
            <div id="disqus_thread"><iframe id="dsq-app1" name="dsq-app1" allowtransparency="true" frameborder="0" scrolling="no" tabindex="0" title="Disqus" width="100%" src="https://disqus.com/embed/comments/?base=default&amp;version=4aa09c5f8e7ed94c5680db6d0895ecf5&amp;f=riotengineeringtechblog&amp;t_i=article-19&amp;t_u=https%3A%2F%2Fengineering.riotgames.com%2Fnews%2Fdocker-jenkins-data-persists&amp;t_d=%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20Docker%20%26%20Jenkins%3A%20Data%20that%20Persists%20%20%20%20%20%20%20%20%0A%20%20%20%20&amp;t_t=%0A%0A%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20%20Docker%20%26%20Jenkins%3A%20Data%20that%20Persists%20%20%20%20%20%20%20%20%0A%20%20%20%20&amp;s_o=default" style="width: 1px !important; min-width: 100% !important; border: none !important; overflow: hidden !important; height: 6946px !important;" horizontalscrolling="no" verticalscrolling="no"></iframe></div>
        </div>

        <noscript>Please enable JavaScript to view the &lt;a href="https://disqus.com/?ref_noscript" rel="nofollow"&gt;comments powered by Disqus.&lt;/a&gt;</noscript>

    
</article>

    <div class="js-zone-bottom" data-url="/news/docker-jenkins-data-persists" data-disq-id="article-19" data-disq-path="https://engineering.riotgames.com/news/docker-jenkins-data-persists" data-disq-title="Docker &amp; Jenkins: Data that Persists"></div>

    <script>
        /* * * CONFIGURATION VARIABLES * * */
        var disqus_shortname = 'riotengineeringtechblog';
        var disqus_identifier = 'article-19';

        /* * * DON'T EDIT BELOW THIS LINE * * */
        (function() {
            var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
            dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
            (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
        })();
    </script>


                <!-- Stopper for sticky aside -->
                <div class="js-sticky-stop"></div>

            </div>
