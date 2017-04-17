
<h2 id="backup-restore-or-migrate-data-volumes">Backup, restore, or migrate data volumes</h2>
<div class="language-bash highlighter-rouge"><pre class="highlight"><code class="hljs ruby"><span class="gp">$ </span>docker run --rm --volumes-from dbstore -v <span class="k">$(</span><span class="nb">pwd</span><span class="k">)</span><span class="hljs-symbol">:/backup</span> ubuntu tar cvf /backup/backup.tar /dbdata
</code></pre>
</div>
<p>Here you’ve launched a new container and mounted the volume from the
<code class="highlighter-rouge">dbstore</code> container. You’ve then mounted a local host directory as
<code class="highlighter-rouge">/backup</code>. Finally, you’ve passed a command that uses <code class="highlighter-rouge">tar</code> to backup the
contents of the <code class="highlighter-rouge">dbdata</code> volume to a <code class="highlighter-rouge">backup.tar</code> file inside our
<code class="highlighter-rouge">/backup</code> directory. When the command completes and the container stops
we’ll be left with a backup of our <code class="highlighter-rouge">dbdata</code> volume.</p>
<p>You could then restore it to the same container, or another that you’ve made
elsewhere. Create a new container.</p>
<div class="language-bash highlighter-rouge"><pre class="highlight"><code class="hljs dockerfile"><span class="gp">$ </span>docker <span class="hljs-keyword">run</span> -v /dbdata --name dbstore2 ubuntu /bin/bash
</code></pre>
</div>
<p>Then un-tar the backup file in the new container`s data volume.</p>
<div class="language-bash highlighter-rouge"><pre class="highlight"><code class="hljs ruby"><span class="gp">$ </span>docker run --rm --volumes-from dbstore2 -v <span class="k">$(</span><span class="nb">pwd</span><span class="k">)</span><span class="hljs-symbol">:/backup</span> ubuntu bash -c <span class="s2"><span class="hljs-string">"cd /dbdata &amp;&amp; tar xvf /backup/backup.tar --strip 1"</span></span>
</code></pre>
</div>
