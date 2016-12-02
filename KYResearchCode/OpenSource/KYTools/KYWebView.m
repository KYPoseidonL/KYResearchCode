//
//  KYWebView.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 15/11/9.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import "KYWebView.h"

@implementation KYWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        UIMenuItem *flag = [[UIMenuItem alloc] initWithTitle:@"定义" action:@selector(flag:)];
//        UIMenuController *menu = [UIMenuController sharedMenuController];
//        [menu setMenuItems:[NSArray arrayWithObjects:flag, nil]];
    }
    return self;
}

/**
 cut: 剪切选中文字到剪贴版。
 copy: 拷贝/复制选中文字到剪贴版。
 select: 当处于文本编辑模式时，选中光标当前位置的一个单词。
 selectAll: 选中当前页所有文字。
 paste: 粘贴剪贴版中的文本到当前光标位置。
 delete: 处于文本编辑模式时，删除选中的文本。（since iOS 3.2）
 _promptForReplace: 即为上面Google+图片中显示的“替换为...”菜单，点击之后会给出与当前选中单词相近的其他单词。
 _showTextStyleOptions: 处于文本编辑模式时，用于编辑字体风格属性，如粗体/斜体等。
 _define: 调用iOS系统内置的英语词典，解释选中的单词。如果内置词典中找不到所选单词，则该项不予显示。
 _accessibilitySpeak: 朗读当前选中的文本。
 _accessibilityPauseSpeak: 暂停朗读文本。
 makeTextWritingDirectionRightToLeft: 调整选中文本的书写格式为从右至左。阿拉伯语会用到。（since iOS 5.0）
 makeTextWritingDirectionLeftToRight: 调整选中文本的书写格式为从左至右。（since iOS 5.0
 
 */

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
   
    if (action == @selector(copy:)) {
        return YES;
    }
    
    if (action == @selector(_define:)) {
        return YES;
    }
    
    return [super canPerformAction:action withSender:sender];
}

- (void)copy:(id)sender {
    
    [super copy:sender];
    
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    if (pasteBoard.string != nil) {
        DDLogDebug(@"%@", pasteBoard.string);
    }
}


@end
