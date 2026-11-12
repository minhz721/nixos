{
  services.udev.extraRules = ''
    # Mouse(XCTECH Wireless-Receiver)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="249a", ATTR{idProduct}=="5c2f", TEST=="power/control", ATTR{power/control}="on"

    # Xinmeng M75 2.4G (Microdia 2.4G Dongle)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0c45", ATTR{idProduct}=="fefa", TEST=="power/control", ATTR{power/control}="on"
  '';
}
