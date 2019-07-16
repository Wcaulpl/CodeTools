//
//  XYDropMenu.m
//  DDPay
//
//  Created by htmj on 2019/7/12.
//  Copyright © 2019年 htmj. All rights reserved.
//

#import "XYDropMenu.h"
#import "XYDropMenuTitleItem.h"
#import "XYDropMenuModel.h"

@interface XYDropMenu ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** 遮罩 */
@property (nonatomic , weak) UIControl *filterCover;

@property (nonatomic, strong) NSArray<NSNumber *> *dropMenuTypes;

@property (nonatomic, strong) NSArray<UIView *> *dropScreenViews;


@end

// ScreenWidth & kScreenHeight
#define kXYScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kXYScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation XYDropMenu

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
    if (self) {
        self.durationTime = .5;
        [self setupUI];
        
    }
    return self;
}

- (UICollectionViewFlowLayout *)flowLayout {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.01f;
    flowLayout.minimumInteritemSpacing = 0.01f;
    return flowLayout;
}
- (void)setupUI {
    self.delegate = self;
    self.dataSource = self;
    self.layer.borderColor = [UIColor clearColor].CGColor;
    [self registerClass:[XYDropMenuTitleItem class] forCellWithReuseIdentifier:@"XYDropMenuTitleItem"];
}

#pragma mark - setter

- (void)setTitles:(NSArray *)titles {
    NSMutableArray *menutitles = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++) {
        XYDropMenuModel *model = XYDropMenuModel.new;
        model.text = titles[i];
        if (i < _dropMenuTypes.count) {
            model.type = [_dropMenuTypes[i] unsignedIntegerValue];
        }
        if (i < _dropScreenViews.count) {
            model.screenView = _dropScreenViews[i];
        }
        [menutitles addObject:model];
    }
    _titles = menutitles;
}

- (void)setResetSeletctTitle:(NSString *)resetSeletctTitle {
    XYDropMenuModel *model = nil;
    for (XYDropMenuModel *obj in self.titles) {
        if (obj.select) {
            model = obj;
        }
    }
    if (!model) {
        return;
    }
    model.text = resetSeletctTitle?:@"";
    [self closeMenu];
}

- (void)setDropMenuTypes:(NSArray *)dropMenuTypes {
    _dropMenuTypes = dropMenuTypes;
    if (self.titles) {
        for (int i = 0; i < _titles.count; i++) {
            if (i < dropMenuTypes.count) {
                XYDropMenuModel *model = _titles[i];
                model.type = [dropMenuTypes[i] unsignedIntegerValue];
            }
        }
    }
}

- (void)setDropScreenViews:(NSArray<UIView *> *)dropScreenViews {
    _dropScreenViews = dropScreenViews;
    if (self.titles) {
        for (int i = 0; i < _titles.count; i++) {
            if (i < dropScreenViews.count) {
                XYDropMenuModel *model = _titles[i];
                model.screenView = dropScreenViews[i];
            }
        }
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *imageView = (UIImageView *)self.backgroundView;
    imageView.image = backgroundImage;
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    if (!_titleSeletedColor) {
        _titleSeletedColor = titleNormalColor;
    }
}

- (void)setNormalImageName:(NSString *)normalImageName {
    _normalImageName = normalImageName;
    if (!_normalImageName) {
        _seletedImageName = normalImageName;
    }
}

- (UIControl *)filterCover {
    if (_filterCover == nil) {
        UIControl *filterCover = [[UIControl alloc]init];
        filterCover.frame = CGRectMake(0, CGRectGetMaxY(self.frame) + FBNavigationBarH, kXYScreenWidth, 0);;
        [filterCover addTarget:self action:@selector(closeMenu) forControlEvents:UIControlEventTouchUpInside];
        filterCover.backgroundColor = [UIColor clearColor];
        [[UIApplication sharedApplication].keyWindow addSubview:self.filterCover=filterCover];
    }
    return _filterCover;
}

#pragma mark - 消失

- (void)closeMenu {
    [self dismiss];
    for (XYDropMenuModel *model in self.titles) {
        model.select = NO;
        [model.screenView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.5];
    }
    [self reloadData];
}
- (void)dismiss {
    self.filterCover.backgroundColor = [UIColor clearColor];
    XYDropMenuModel *model = nil;
    for (XYDropMenuModel *obj in self.titles) {
        if (obj.select) {
            model = obj;
        }
    }
    if (!model) {
        return;
    }

    [UIView animateWithDuration:self.durationTime animations:^{
        if (model.type == XYDropMenuTypeUpTodown /** 至上而下 */) {
            model.screenView.frame = CGRectMake(0, CGRectGetMaxY(self.frame) + FBNavigationBarH, kXYScreenWidth, 0);
            self.filterCover.frame = CGRectMake(0, CGRectGetMaxY(self.frame) + FBNavigationBarH, kXYScreenWidth, 0);
        } else if (model.type == XYDropMenuTypeDownToUp /** 至下而上 */) {
            model.screenView.frame = CGRectMake(0, kXYScreenHeight, kXYScreenWidth, 0);
            self.filterCover.frame = CGRectMake(0, kXYScreenHeight, kXYScreenWidth, 0);
        }
    } completion:^(BOOL finished) {
//        [text.screenView removeFromSuperview];
    }];
}

#pragma mark - 弹出
- (void)show {

    XYDropMenuModel *model = nil;
    for (XYDropMenuModel *obj in self.titles) {
        if (obj.select) {
            model = obj;
        }
        if (model.screenView.superview) {
            if (!model.select) {
                [model.screenView removeFromSuperview];
            }
        }
    }
    if (!model) {
        return;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:model.screenView];
    if (model.type == XYDropMenuTypeUpTodown /** 至上而下 */) {
        model.screenView.frame = CGRectMake(0, CGRectGetMaxY(self.frame) + FBNavigationBarH, kXYScreenWidth, 0);
        self.filterCover.frame = CGRectMake(0, CGRectGetMaxY(self.frame) + FBNavigationBarH, kXYScreenWidth, 0);
    } else if (model.type == XYDropMenuTypeDownToUp /** 至下而上 */) {
        model.screenView.frame = CGRectMake(0, kXYScreenHeight, kXYScreenWidth, 0);
        self.filterCover.frame = CGRectMake(0, CGRectGetMaxY(self.frame) + FBNavigationBarH, kXYScreenWidth, 0);
    }
    [UIView animateWithDuration:self.durationTime animations:^{
        if (model.type == XYDropMenuTypeUpTodown /** 至上而下 */) {
            model.screenView.frame = CGRectMake(0, CGRectGetMaxY(self.frame) + FBNavigationBarH, kXYScreenWidth, model.screenHeight);
        } else if (model.type == XYDropMenuTypeDownToUp /** 至下而上 */) {
            model.screenView.frame = CGRectMake(0, kXYScreenHeight-model.screenHeight, kXYScreenWidth, model.screenHeight);
        }
        self.filterCover.frame = CGRectMake(0, CGRectGetMaxY(self.frame) + FBNavigationBarH, kXYScreenWidth, kXYScreenHeight - CGRectGetMaxY(self.frame) - FBNavigationBarH);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.filterCover.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:102.0/255];
        } completion:^(BOOL finished) {

        }];
    }];
}

#pragma mark - collectionViewDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section  {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kXYScreenWidth /self.titles.count, CGRectGetHeight(self.frame) - 0.01f);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}
#pragma mark - - - 返回collectionView item
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYDropMenuTitleItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"XYDropMenuTitleItem" forIndexPath:indexPath];
    XYDropMenuModel *model = self.titles[indexPath.item];
    UIColor *textColor = model.select ? self.titleSeletedColor : self.titleNormalColor;
    NSString *imageName = model.select ? self.seletedImageName : self.normalImageName;
    
    [cell setItemText:model.text textColor:textColor font:self.titleFont imageName:imageName maxWidth:kXYScreenWidth/self.titles.count];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    XYDropMenuModel *model = self.titles[indexPath.item];
    [self dismiss];
    model.select = !model.select;
    if (model.select) {
        for (XYDropMenuModel *obj in self.titles) {
            if (![obj isEqual:model]) {
                obj.select = NO;
            }
        }
        [self show];
    }
    [collectionView reloadData];
}
@end
