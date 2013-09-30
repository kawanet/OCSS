# OCSS - Objective-CSS

Experimental CSS Parser for iOS

## SYNOPSIS

```obj-c
NSURL *url = [NSBundle.mainBundle.resourceURL URLByAppendingPathComponent:@"style.css"];
OCSS *css = [[OCSS alloc] initWithContentsOfURL:url];
OCSSStyleDeclaration *style = [css getComputedStyleForSelector:@".logo"];
NSString *fontWeight = style.fontWeight;
```

## DEMO APPICATION

<img src="https://github.com/kawanet/OCSS/raw/master/public/screen1.png" border="1">

## AUTHOR

Yusuke Kawasaki http://www.kawa.net/

## COPYRIGHT

The following copyright notice applies to all the files provided in this distribution, including binary files, unless explicitly noted otherwise.

    Copyright 2013 Yusuke Kawasaki
