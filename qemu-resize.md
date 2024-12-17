<h3 id="resize-disk-space">Resize Disk Space</h3>
<p>In <strong>Termux</strong> (outside VM), run:</p>
<pre><code>qemu-img resize debian-12-nocloud-amd64.qcow2 +30G
</code></pre>
<p>Change <code>debian-12-nocloud-amd64.qcow2</code> to the real file name. <code>+30G</code> indicates increasing 30GB disk image. You can adjust the size as needed.<br />
Inside VM, run:</p>
<pre><code>sudo apt update
sudo apt install parted e2fsprogs -y
sudo parted /dev/sda
print
fix
resizepart 1 100%
quit
sudo resize2fs /dev/sda1
</code></pre>
