sudo qemu-system-x86_64 -kernel bzImage -nographic \
-device virtio-scsi-pci,id=scsi0 \
-device scsi-hd,drive=hd0 \
-drive format=raw,file=qemuimg,id=hd0,if=none,aio=native,cache=none -append "root=/dev/sda rw console=ttyS0" \
-m 180G -cpu host -enable-kvm -smp 8 -machine type=pc,accel=kvm,mem-merge=off \
-object memory-backend-ram,id=mem0,size=80G,policy=bind,host-nodes=0,prealloc=off \
-object memory-backend-ram,id=mem1,size=100G,policy=bind,host-nodes=2,prealloc=off \
-numa node,memdev=mem0,cpus=0-7,nodeid=0 \
-numa node,memdev=mem1,nodeid=1 \
-net user,hostfwd=tcp::5556-:22 \
-net nic,model=virtio \
-device virtio-net,netdev=network0 \
-netdev tap,id=network0,ifname=tap0,script=no,downscript=no \
-qmp unix:./qmp-sock,server,nowait \
-serial mon:stdio

#-numa dist,src=0,dst=1,val=20 \
