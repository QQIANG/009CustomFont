//
//  ViewController.swift
//  CustomFont
//
//  Created by JNYJ on 14-11-15.
//  Copyright (c) 2014年 JNYJ. All rights reserved.
//


/*
IMPT
From  http://www.cocoachina.com/bbs/read.php?tid-105689.html
By  "mhmwadm"
Note: Changed part of the codes by JNYJ

3.4	使用自定义字体
1.添加对应的字体(.ttf或.odf)到工程的resurce，例如my.ttf。
2.在info.plist中添加一项 Fonts provided by application (item0对应的value为my.ttf，添加多个字体依次添加就可以了)。
3.使用时aLabel.font=[UIFontfontWithName:@"XXX" size:30]; 注意XXX不一定是my，这里是RETURN TO CASTLE。
可以用如下方法查看familyname和fontname：
NSArray *familyNames = [UIFont familyNames];
for( NSString *familyNameinfamilyNames ){
printf( "Family: %s \n", [familyNameUTF8String] );
NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
for( NSString *fontNameinfontNames ){
printf( "\tFont: %s \n", [fontNameUTF8String] );
}
}

// the second method

#import <QuartzCore/QuartzCore.h>
#import <dlfcn.h>

@interface FontObj ()
@end

@implementation FontObj

+ (NSUInteger)loadFonts
{
__block NSUInteger newFontCount = 0;
static dispatch_once_t onceToken;
dispatch_once(&onceToken, ^{

NSBundle *frameworkBundle = [NSBundle bundleWithIdentifier:@"com.apple.GraphicsServices"];
const char *frameworkPath = [[frameworkBundle executablePath] UTF8String];
if (frameworkPath) {
void *graphicsServices = dlopen(frameworkPath, RTLD_NOLOAD | RTLD_LAZY);
if (graphicsServices) {
BOOL (*GSFontAddFromFile)(const char *) = dlsym(graphicsServices, "GSFontAddFromFile");
if (GSFontAddFromFile) {
NSArray *array_fonts = [[NSBundle mainBundle] pathsForResourcesOfType:@"ttf" inDirectory:nil];
array_fonts = [array_fonts arrayByAddingObjectsFromArray:[[NSBundle mainBundle] pathsForResourcesOfType:@"ttc" inDirectory:nil]];
for (NSString *fontFile in array_fonts)
newFontCount += GSFontAddFromFile([fontFile UTF8String]);
}
}
}
});
NSLog(@"%s %d", __FUNCTION__, newFontCount);
return newFontCount;
}

+ (id)fontWithName:(NSString *)name
{
__autoreleasing FontObj *obj = [[FontObj alloc] init];
obj.fontName = name;
return obj;
}

- (id)copy
{
__autoreleasing FontObj *obj = [[FontObj alloc] init];
obj.fontName = self.fontName;
return obj;
}

- (UIFont *)fontWithSize:(CGFloat)size
{
return [UIFont fontWithName:self.fontName size:size];
}

- (NSString *)description
{
return [NSString stringWithFormat:@"<%@ %p: name = %@>", [self class], self, self.fontName];
}


//Testing

- (void)configData
{
[FontObj loadFonts];
self.pDict_font = TextFontsDict;
self.pDict_color = TextColorsDict;

_pFontObj_temp = [FontObj fontWithName:[[UIFont systemFontOfSize:14.f] fontName]];
_pColor_temp = [UIColor darkGrayColor];

NSArray *color_list = COLOR_LIST;

CGFloat left = 0;
CGFloat height = 0;
for (int i = 0; i < color_list.count; i++) {
NSString *key = color_list[i];
UIColor *color = self.pDict_color[key];
Vcell_color_pick *cell = [Vcell_color_pick cellWithColor:color
delegate:self];
cell.frame = CGRectMake(left, 0.f, cell.frame.size.width, cell.frame.size.height);
cell.autoresizingMask = UIViewAutoresizingNone;
[self.pVscroll_color_list addSubview:cell];
left += cell.frame.size.width;
height = cell.frame.size.height;
}

self.pVscroll_color_list.contentSize = CGSizeMake(left, height);

left = 0.f;
for (int i = 0; i < self.pDict_font.allKeys.count; i++) {
NSString *key = self.pDict_font.allKeys[i];
NSString *font_name = self.pDict_font[key];
FontObj *font_obj = nil;

font_obj = [FontObj fontWithName:[[UIFont fontWithName:font_name size:14.f] fontName]];

Vcell_font_pick *cell = [Vcell_font_pick cellWithFont:font_obj
color:_pColor_temp
delegate:self];
cell.frame = CGRectMake(left, 0.f, cell.frame.size.width, cell.frame.size.height);
cell.autoresizingMask = UIViewAutoresizingNone;
[self.pVscroll_font_list addSubview:cell];
left += cell.frame.size.width - 1.f;
height = cell.frame.size.height;
}

self.pVscroll_font_list.contentSize = CGSizeMake(left, height);
}

//

UIFont *font = [_font_obj fontWithSize:20.f];

*/



import UIKit

class ViewController: UIViewController {

	@IBOutlet var label_top : UILabel!
	@IBOutlet var label_middle : UILabel!
	@IBOutlet var label_bottom : UILabel!


	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.

		// The first method
		/*

		Family------------------------------------> DFPShaoNvW5-GB
		Font name  DFPShaoNvW5
		*/
		if let item = self.label_top {
			self.label_top.text = "汉休%&￥ABCefg1234567890"
			self.label_top.font = UIFont(name: "DFPShaoNvW5", size: 14)
		}

		/*
		Family------------------------------------> NSimSun
		Font name  NSimSun
		*/

		if let item = self.label_bottom {
			self.label_middle.text = "汉休%&￥ABCefg1234567890"
			self.label_middle.font = UIFont(name: "NSimSun", size: 14)
		}
		/*
		Family------------------------------------> Fixedsys Excelsior 3.01
		Font name  FixedsysExcelsiorIIIb
		*/

		if let item = self.label_bottom {
			self.label_bottom.text = "汉休%&￥ABCefg1234567890"
			self.label_bottom.font = UIFont(name: "FixedsysExcelsiorIIIb", size: 14)
		}

		var fontNames : NSArray  = UIFont.familyNames()
		for font in fontNames {
			if let item: NSString = font as? NSString{
				println("Family------------------------------------> \(item)")
				var fontNames_ : NSArray = UIFont.fontNamesForFamilyName(item)
				for font_ in fontNames_ {
					println("Font name  \(font_)")
				}
			}
		}
		//
		//		NSArray *familyNames = [UIFont familyNames];
		//		for( NSString *familyNameinfamilyNames ){
		//			printf( "Family: %s \n", [familyNameUTF8String] );
		//			NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
		//			for( NSString *fontNameinfontNames ){
		//			printf( "\tFont: %s \n", [fontNameUTF8String] );
		//			}
		//		}

		//The  second method
		




	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

