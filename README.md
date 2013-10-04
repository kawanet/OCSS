# OCSS - Objective-CSS for iOS

The OCSS library is a CSS Parser implementing a part of CSS2, CSS3, DOM and HTML5.

## SYNOPSIS

```
NSURL *url = [NSBundle.mainBundle.resourceURL URLByAppendingPathComponent:@"style.css"];
OCSS *css = [[OCSS alloc] initWithContentsOfURL:url];
OCSSStyleDeclaration *style = [css getComputedStyleForSelector:@".table thead th"];
NSString *padding = style[@"padding"];
```

## DEMO APPICATION

<img src="https://github.com/kawanet/OCSS/raw/master/public/screen1.png">&nbsp;<img src="https://github.com/kawanet/OCSS/raw/master/public/screen2.png">

## COMPATIBILITIES

### This supports:

- HTML5's `getComputedStyle`-like 
- Most of CSS3 selectors
  - Universal selector: `*`
  - Type selector: `E`
  - Attribute selectors: `[attr]`, `[class=nav]`, `[class^="icon-"]`
  - Class selectors: `.class`
  - ID selectors: `#id`
  - Descendant/Child combinators: `E F`, `E > F`
  - Sibling combinators: `E + F`, `E ~ F`

### This does NOT support:

- Structural pseudo-classes selectors: `:first-child` (partially available)
- Media queries: `@media screen and (min-width: 321px) and (max-device-width: 920px) { }` (parsed and ignored)
- Import rule: `@import url(style.css);` (parsed and ignored)
- Charset rule: `@charset "utf-8";` (parsed and ignored)
- Inherited property value calculation: `font-size: inherit;`
- Important priority: `color: red !important`

## SEE ALSO

- http://www.w3.org/TR/domcore/
- http://www.w3.org/TR/DOM-Level-2-HTML/
- http://www.w3.org/TR/DOM-Level-2-Core/
- http://www.w3.org/TR/DOM-Level-2-Style/
- http://www.w3.org/TR/html5/
- http://www.w3.org/TR/css3-selectors/

## AUTHOR

Yusuke Kawasaki http://www.kawa.net/

## COPYRIGHT

The following copyright notice applies to all the files provided in this distribution, including binary files, unless explicitly noted otherwise.

    Copyright 2013 Yusuke Kawasaki
