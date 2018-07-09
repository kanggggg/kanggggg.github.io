---
title: iOS调用系统邮件
date: 2018-07-09 11:28:45
tags: 
  - iOS Memo
categories:
  - iOS
toc: true
comments: true
---

iOS调用系统邮件发送Email主要使用的 `MFMailComposeViewController` 。

## Example

```objectivec
//引用头文件
#import <MessageUI/MFMailComposeViewController.h>

- (void)sendEmail {
    BOOL canSendMail = [MFMailComposeViewController canSendMail];
    if (!canSendMail) {
        //不能发送邮件
        return;
    }

    MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];

    //设置代理，MFMailComposeViewControllerDelegate
    mailController.mailComposeDelegate = self;

    //设置邮件内容
    [mailController setSubject:@"标题"]; //标题
    [mailController setToRecipients:@[@"xxxx@example.com"]]; //收件地址
    [mailController setCcRecipients:@[@"yyyy@example.com"]]; //抄送
    [mailController setCcRecipients:@[@"zzzz@example.com"]]; //密送
    NSString *messageBody = [NSMutableString stringWithFormat:@"你好，这是测试邮件"]; //邮件正文
    [mailController setMessageBody:messageBody isHTML:NO];

    //附件
    NSString *path = @"文件路径";
    NSData *data = [NSData dataWithContentsOfFile:path];
    [mailController addAttachmentData:data mimeType:@"" fileName:@"文件名"];

    //
    [self presentViewController:mailController animated:YES completion:nil];  
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    //MFMailComposeResultCancelled   User canceled the composition.  
    //MFMailComposeResultSaved       User successfully saved the message.
    //MFMailComposeResultSent        User successfully sent/queued the message.
    //MFMailComposeResultFailed      User's attempt to save or send was unsuccessful. 
}
```
