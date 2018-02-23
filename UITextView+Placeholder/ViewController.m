//
//  ViewController.m
//  UITextView+Placeholder
//
//  Created by GHome on 2018/2/22.
//  Copyright © 2018年 GHome. All rights reserved.
//

#import "ViewController.h"
#import "UITextView+Placeholder.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 44)];
    textView.placeholder = @"请输入文字";
    textView.placeholderColor = [UIColor redColor];
    textView.placeholderFont = [UIFont systemFontOfSize:20];
 
    textView.layer.masksToBounds = YES;
    textView.layer.cornerRadius = 5;
    textView.layer.borderWidth = 0.5;
    [self.view addSubview:textView];
    self.tableView.frame = CGRectMake(0, textView.frame.size.height + textView.frame.origin.y, self.view.bounds.size.width, 500);
    [self.view addSubview:self.tableView];
    textView.textViewHeight = ^(CGFloat textViewHeight,UITextView *textView) {
        textView.frame = CGRectMake(0, 100, self.view.bounds.size.width, textViewHeight);
        self.tableView.frame = CGRectMake(0, textView.frame.size.height + textView.frame.origin.y, self.view.bounds.size.width, 500);
    };

}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"改变");
}
- (void)setupUI {
  
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = @"我是tableView";
    return cell;
}
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
    }
    return _tableView;
}


@end
