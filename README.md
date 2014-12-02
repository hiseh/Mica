#Mica
Mica is a light library for IOS. 

Version 0.2.0

##Requirements
This is tested against IOS 6.0+ and uses ARC.

##License
Mica is available under the MIT license. See the LICENSE file for more info.

##Architecture
* `MCUI`
	- `UIColor+MCColor`
	- `UILabel+MCLabel`
	- `UITextField+MCTextField`
	- `UITextView+MCTextView`

##Document
###Parameters File
You can define the `MC_PARAMETERS_FILE` variability in Mica.h file. The parameers file architecutre is
![Parameters File Screenshot](/doc/parameters_file_screenshot.png)

###UIColor+MCColor
####Create UIColor Object with HEX Value
```objective-c
[UIColor colorFromHEX:@"d90070"]
```
####Create UIColor Object from Parameters File
```objective-c
[UIColor colorFromPlistWithKey:@"PinkColor"]
```

##Author

Created by Hiseh<br />
[GitHub](https://github.com/hiseh/Mica.git)

