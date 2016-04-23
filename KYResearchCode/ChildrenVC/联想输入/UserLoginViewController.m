//
//  UserLoginViewController.m
//  KYStudyDemo
//
//  Created by iOS Developer 3 on 15/11/10.
//  Copyright © 2015年 KYPoseidonL. All rights reserved.
//

#import "UserLoginViewController.h"

@interface UserLoginViewController ()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    BOOL _showList;
}

@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *emalArray; //邮箱后缀
@property (nonatomic, strong) NSMutableArray *tabviewData; //服务器数据
@property (nonatomic, strong) UITextField *accountTextField;

@end

@implementation UserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerNotifications];
    
    _showList = NO;//默认不显示
    
    [self setup];
}

- (NSArray *)emalArray {

    if (!_emalArray) {
        _emalArray = @[@"sohu.com",@"sina.com",@"sina.cn",@"163.com",@"126.com",@"qq.com",@"hotmail.com",@"gmail.com"];
    }
    return _emalArray;
}

- (NSMutableArray *)tabviewData {

    if (!_tabviewData) {
        _tabviewData = [[NSMutableArray alloc] init];
    }
    return _tabviewData;
}

- (void)setup {

    _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 200.f, 49.f)];
    _accountTextField.centerX = kScreen_Width/2;
    _accountTextField.top = 100.f;
    _accountTextField.backgroundColor = kColor(kBackgroundColor);
    _accountTextField.delegate = self;
    [self.view addSubview:_accountTextField];

    //下拉列表
    _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,kScreen_Width-40.f,120)];
    _listTableView.top = _accountTextField.bottom+20.f;
    _listTableView.left = 20;
    _listTableView.dataSource = self;
    _listTableView.delegate = self;
    _listTableView.bounces = NO;
    _listTableView.backgroundColor = [UIColor whiteColor];
    _listTableView.separatorColor = kColor(@"cccccc");
    _listTableView.hidden = !_showList;//一开始listView是隐藏的，此后根据showList的值显示或隐藏
    [self.view addSubview:_listTableView];
}

-(BOOL)showList{//setShowList:No为隐藏，setShowList:Yes为显示
    return _showList;
}

-(void)setShowList:(BOOL)iShow{
    _showList=iShow;
    _listTableView.hidden=!iShow;
}

//核心代码
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    //判断text 是否输入过@ 如果输入过则不出现下啦菜单
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField ==_accountTextField) {
        //是否包含@
        if ([text containsString:@"@"]) {
            [self setShowList:YES];
            [self.tabviewData removeAllObjects];
            //范围
            NSRange range = [text rangeOfString:@"@"];
            if ((range.location + range.length) == text.length) {
                for (NSString *str in self.emalArray) {
                    [self.tabviewData addObject:[NSString stringWithFormat:@"%@%@",text,str]];
                }
            }else{
                NSString *suffix = [text substringWithRange:NSMakeRange(range.location+range.length, text.length-(range.location+range.length))];
                NSString *headText = [text substringWithRange:NSMakeRange(0,range.location+range.length)];
                for (NSString *str in self.emalArray) {
                    //匹配
                    if ([str hasPrefix:suffix]) {
                        
                        [self.tabviewData addObject:[NSString stringWithFormat:@"%@%@",headText,str]];
                        
                    }
                }
                if (self.tabviewData.count<=0) {
                    [self setShowList:NO];
                }
            }
            
            [self.listTableView reloadData];
        }else
        {
            [self setShowList:NO];
        }
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    //返回一个BOOL值指明是否允许根据用户请求清除内容
    
    //可以设置在特定条件下才允许清除内容
    
    [self setShowList:NO];
    return YES;
}

#pragma  mark 监听键盘
- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification"
                                              object:nil];
}

- (void)dealloc {
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)textFiledEditChanged:(NSNotification *)obj {
    //此处可以拿到 正在输入的值 做一些处理
}

#pragma mark listViewdataSource method and delegate method
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    return self.tabviewData.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid=@"listviewid";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellid];
    }

    cell.textLabel.text = [self.tabviewData objectAtIndex:indexPath.row];
    cell.textLabel.font = _accountTextField.font;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //显示值
    NSString *string = [self.tabviewData objectAtIndex:indexPath.row];
    _accountTextField.text = string;
    [self setShowList:NO];
}

@end
