Image Capture
=============

gphoto2
-------

[gPhoto2](http://gphoto.sourceforge.net/proj/) is a free, redistributable, ready to use set of digital camera software applications for Unix-like systems, written by a whole team of dedicated volunteers around the world. It supports more than [1800 cameras](http://gphoto.sourceforge.net/proj/libgphoto2/support.php).

Installation under Ubuntu is simple:

~~~~ {.bash}
apt-get install gphoto2 libgphoto2-6 libgphoto2-6-dev
~~~~

### (Optional) Install From Source

Optionally, you could install the latest version from source.

Check [the installation script](https://github.com/edwardtoday/LED-Calibration/blob/master/script/install_gphoto2.sh) for more details.

Capture an Image
----------------

Before you write any code to play with the camera, I recommend checking the capabilities of your camera with `gphoto2`.

Connect your camera through USB. Unmount the device if it is automatially mounted.

Check if gphoto2 detects the camera.

~~~~ {.bash}
gphoto2 --auto-detect
~~~~

You should see output like the following if `gphoto2` detected the camera.

     Model                          Port
     ----------------------------------------------------------
     Canon EOS 7D                   usb:002,003

Check the capabilities of the camera.

~~~~ {.bash}
gphoto2 --summary
~~~~

Here is a summary of Canon EOS 7D.

    Camera summary:
    Manufacturer: Canon Inc.
    Model: Canon EOS 7D
      Version: 3-2.0.3
      Serial Number: 51b7b9f89f2244cea68db8ace79efabe
    Vendor Extension ID: 0xb (2.0)

    Capture Formats: JPEG
    Display Formats: Association/Directory, Script, DPOF, MS AVI, MS Wave, JPEG, CRW, Unknown(b103), Unknown(bf02), Defined Type, Unknown(b104)

    Device Capabilities:
            File Download, File Deletion, File Upload
            No Image Capture, No Open Capture, Canon EOS Capture, Canon EOS Shutter Button

    Storage Devices Summary:
    store_00010001:
            StorageDescription: CF
            VolumeLabel: None
            Storage Type: Removable RAM (memory card)
            Filesystemtype: Digital Camera Layout (DCIM)
            Access Capability: Read-Write
            Maximum Capability: 15996256256 (15255 MB)
            Free Space (Bytes): 14066253824 (13414 MB)
            Free Space (Images): -1

    Device Property Summary:
    Property 0xd402:(read only) (type=0xffff) 'Canon EOS 7D'
    Property 0xd407:(read only) (type=0x6) 1
    Property 0xd406:(readwrite) (type=0xffff) 'Unknown Initiator'
    Property 0xd303:(read only) (type=0x2) 1

Capture an image (if the camera reported image capture support in the summary output.)

~~~~ {.bash}
gphoto2 --capture-image
~~~~

The camera will focus (if not set to manual focus), take a picture and show the file locations on camera.

    New file is in location /capt0000.jpg on the camera
    New file is in location /capt0000.cr2 on the camera

If autofocus fails, you may see errors like

    *** Error ***
    Canon EOS Capture failed to release: Perhaps no focus?
    ERROR: Could not capture image.
    ERROR: Could not capture.

Camera USB Modes
----------------

DLSRs normally have multiple modes for usb connection. My Canon 350D has two, *Print/PTP* and *PC*.

The camera has different capabilities or configurations in different modes.

In *Print/PTP* mode, `gphoto2 --abilities` shows

    Abilities for camera             : Canon EOS 350D
    Serial port support              : no
    USB support                      : yes
    Capture choices                  :
                                     : Capture not supported by the driver
    Configuration support            : no
    Delete selected files on camera  : yes
    Delete all files on camera       : no
    File preview (thumbnail) support : yes
    File upload support              : yes

`gphoto2 --list-config` shows

    /main/actions/syncdatetime
    /main/settings/ownername
    /main/settings/capturetarget
    /main/settings/capture
    /main/status/serialnumber
    /main/status/manufacturer
    /main/status/cameramodel
    /main/status/deviceversion
    /main/status/vendorextension
    /main/status/model
    /main/status/firmwareversion
    /main/other/d045
    /main/other/d002
    /main/other/d003
    /main/other/d02c
    /main/other/d02d
    /main/other/d049
    /main/other/d032
    /main/other/d031
    /main/other/d034
    /main/other/d033
    /main/other/d02e
    /main/other/d02f
    /main/other/d046
    /main/other/d047
    /main/other/d030
    /main/other/d04a

In *PC* mode, the output of `gphoto2 --abilities` becomes

    Abilities for camera             : Canon Digital Rebel XT (normal mode)
    Serial port support              : no
    USB support                      : yes
    Capture choices                  :
                                     : Image
                                     : Preview
    Configuration support            : yes
    Delete selected files on camera  : yes
    Delete all files on camera       : no
    File preview (thumbnail) support : yes
    File upload support              : no

and the output of `gphoto2 --list-config` turns into

    /main/settings/ownername
    /main/settings/capturesizeclass
    /main/settings/iso
    /main/settings/shootingmode
    /main/settings/shutterspeed
    /main/settings/zoom
    /main/settings/aperture
    /main/settings/exposurecompensation
    /main/settings/imageformat
    /main/settings/focusmode
    /main/settings/flashmode
    /main/settings/beep
    /main/actions/syncdatetime
    /main/status/model
    /main/status/datetime
    /main/status/firmwareversion
    /main/status/driver
    /main/Driver/list_all_files

Note that we have more control of the image capture settings in *PC* mode. But operations (almost anything that need communication with the device) take longer to complete in this mode. File download speed is also considerably lower compared to *Print/PTP* mode.
