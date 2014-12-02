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
* `MCUtilities`
	- `NSNumber+MCNumber`
	- `NSString+MCString`

##Document
###Parameters File
You can define the `MC_PARAMETERS_FILE` variability in Mica.h file. The parameers file architecutre is
![Parameters File Screenshot](/doc/parameters_file_screenshot.png)

###MCUI
####Create UIColor Object with HEX Value
```objective-c
+ (UIColor *)colorFromHEX:(NSString *)hexStr;
```
<br /><br />
**Parameters**<br />
hexStr: The HEX Value. If only include r/g/b color value, alpha value will be 1.0.
<br /><br />
**Return Value**<br />
return UIColor Object.
<br /><br />
**Example**<br />
```objective-c
[UIColor colorFromHEX:@"d90070"]
```

####Create UIColor Object from Parameters File
```objective-c
[UIColor colorFromPlistWithKey:@"PinkColor"]
```

####Create UILabel Object from Parameters File
```objective-c
[UILabel labelFromPlistWithKey:@"Title"]
```

####Create UITextField Object from Parameters File
```objective-c
[UITextField textfieldFromPlistWithKey:@"Signup"]
```

####Create UITextView Object from Parameters File
```objective-c
[UITextView textviewFromPlistWithKey:@"Normal"]
```

##Author

Created by Hiseh<br />
[GitHub](https://github.com/hiseh/Mica.git)

