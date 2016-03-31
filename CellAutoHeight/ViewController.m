//
//  ViewController.m
//  CellAutoHeight
//
//  Created by 成璐飞 on 16/3/18.
//  Copyright © 2016年 成璐飞. All rights reserved.
//

#import "ViewController.h"
#import "AutoHeightCell.h"

#define kScreenBounds ([[UIScreen mainScreen] bounds])
#define kScreenWidth (kScreenBounds.size.width)
#define kScreenHeight (kScreenBounds.size.height)

#define IOS_VERSION_8_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)? (YES):(NO))

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.dataSource = @[@"The first step to creating a fancy animation was creating a UITableViewCell (called BookCell) with flexible constraints. By flexible, I mean that no constraint was absolutely required. The cell included a yellow subview subview with a collapsible height constraint — the height constraint always has a constant of 0, and it initially has a priority of 999. Within the collapsible subview, no vertical constraints are required. We set the priority of all the internal vertical constraints to 998.", @"如《广东省工资支付条例》第三十五 条非因劳动者原因造成用人单位停工、停产，未超过一个工资支付周期（最长三十日）的，用人单位应当按照正常工作时间支付工资。超过一个工资支付周期的，可以根据劳动者提供的劳动，按照双方新约定的标准支付工资；用人单位没有安排劳动者工作的，应当按照不低于当地最低工资标准的百分之八十支付劳动者生活费，生活费发放至企业复工、复产或者解除劳动关系。,来看看劳动法克林顿刷卡思考对方卡拉卡斯的楼房卡拉卡斯的疯狂拉萨的罚款 ,中秋节、十一假期分为两类。一类是法定节假日，即9月30日(中秋节)、10月1日、2日、3日共四天为法定节假日;另一类是休息日，即10月4日至10月7日为休息日。"];
    self.tableView = [[UITableView alloc] initWithFrame:kScreenBounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"AutoHeightCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.tableView.estimatedRowHeight = kScreenHeight;
    if (1) {
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AutoHeightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.labe1.text = self.dataSource[0];
    cell.label2.text = self.dataSource[1];
    return cell;
}

#if 0
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"高度计算");
    
    NSString *str1 = self.dataSource[0];
    NSString *str2 = self.dataSource[1];
    
    CGFloat height1 = [str1 boundingRectWithSize:CGSizeMake(kScreenWidth - 8, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height;
    CGFloat height2 = [str2 boundingRectWithSize:CGSizeMake(kScreenWidth - 8, 99999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13]} context:nil].size.height;
    
    return height1 + height2 + 145 - 16 * 2 + 2;
}
#endif

@end
