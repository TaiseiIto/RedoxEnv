# This makefile is called from ../Makefile
# Don't execute it directly.

QEMU = qemu-system-x86_64
REDOX = ../redox.img
SERIAL_LOG = ../serial.log
VNC = -vnc :0
COMMAND = SDL_VIDEO_X11_DGAMOUSE=0 $(QEMU) -d cpu_reset,guest_errors -smp 4 -m 2048 -chardev stdio,id=debug,signal=off,mux=on,"" -serial chardev:debug -mon chardev=debug -machine q35 -device ich9-intel-hda -device hda-duplex -device nec-usb-xhci,id=xhci -drive file=$(REDOX),format=raw $(VNC)
DEBUG_PORT = 2159
DEBUG = -S -gdb tcp::$(DEBUG_PORT)

# Run Redox on QEMU.
run:
	$(COMMAND) | tee $(SERIAL_LOG)

# Stop Redox on QEMU.
stop:
	for i in $$(ps ax | grep $(QEMU) | grep -v grep | grep -v make | awk '{print $$1}'); do kill $$i; done

# Debug Redox on QEMU.
debug:
	$(COMMAND) $(DEBUG) | tee $(SERIAL_LOG)

