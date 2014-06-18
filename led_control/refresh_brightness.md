Refresh Brightness
==================

Every controller connection class maintains a table of brightness settings.

key: device mac, value: brightness value

When a user task arrives, if it is a

- SetBrightness
    * For single device mac, check for group or broadcast entries, break them.
    * For group mac, remove all single device mac and group mac entries.
    * For broadcast mac, remove all entries.
    * Then add the incoming entry to the table.
- SetMode
    * If target mode is manual, start the timer.
    * If target mode is auto or scheduled, stop the timer.

When the timer expires, traverse the table, generate an auto task to set brightness for each entry, post it.
