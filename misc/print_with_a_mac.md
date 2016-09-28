# Print with a Mac

1. Open "System Preferences.app".
2. Click on "Printers & Scanners" and unlock the preference pane (if necessary).
3. Click on "+" underneath the list of printers and select "Add Printer or Scanner..." in the menu that appears.
4. An "Add" window will appear.
  1. If there is not already an "Advanced" button in its toolbar (on top, alongside "Default", "Fax", "IP", etc.), you'll need to customize the toolbar. Control+click on the toolbar area and select "Customize Toolbar...".
  2. Drag the "Advanced" item up onto the toolbar and click "Done".
5. Click on the "Advanced" button.
  - If you find elements grayed out, you may need to [reset the printing system](https://support.apple.com/en-us/HT201539).
6. Then enter/select the following:
  - Type: "Windows printer via spoolss"
  - Device: "Another Device"
  - URL: `smb://192.168.4.14/%E7%A0%94%E5%8F%91%E4%B8%80%E9%83%A8-HP+LaserJet+Pro+M701+PCL+6`
  - The URL should be encoded with <http://www.url-encode-decode.com/>
  - Name: "研发一部-HP LaserJet Pro M701 PCL 6"
  - Location: "4F"
  - Use: Select "Select Software..." then choose "HP LaserJet Pro M701".