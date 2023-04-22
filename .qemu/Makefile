# This makefile is called from ../Makefile
# Don't execute it directly.

# Run Redox on QEMU.
run:
	SDL_VIDEO_X11_DGAMOUSE=0 qemu-system-x86_64 -d cpu_reset,guest_errors -smp 4 -m 2048 \
	-chardev stdio,id=debug,signal=off,mux=on,"" -serial chardev:debug -mon chardev=debug \
	-machine q35 -device ich9-intel-hda -device hda-duplex -netdev user,id=net0 \
	-device e1000,netdev=net0 -device nec-usb-xhci,id=xhci -cpu host \
	-drive file=`echo ../redox.img`,format=raw

# Stop THEOS on QEMU.
stop:
	for i in $$(ps ax | grep $(QEMU) | grep -v grep | awk '{print $$1}'); do kill $$i; done

