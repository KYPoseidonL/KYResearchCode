//
//  SideslipViewController.m
//  KYResearchCode
//
//  Created by iOS Developer 3 on 17/2/9.
//  Copyright © 2017年 KYPoseidonL. All rights reserved.
//

#import "SideslipViewController.h"
#import "UITableViewRowAction+Extension.h"

@interface SideslipViewController ()

@property (weak, nonatomic) IBOutlet UITableView * tableView;

@end

@implementation SideslipViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if ( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- ( NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray * actionArray = [NSMutableArray array];
    [actionArray removeAllObjects];
    
    UITableViewRowAction * deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"删除");
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    
    UITableViewRowAction * readAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"标为已读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSLog(@"标为已读");
    }];
    
    readAction.backgroundColor = [UIColor lightGrayColor];
    
    [actionArray addObject:deleteAction];
    [actionArray addObject:readAction];
    
    
    return actionArray;
}


@end
