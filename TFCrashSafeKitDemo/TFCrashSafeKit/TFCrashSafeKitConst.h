//
//  TFCrashSafeKitConst.h
//  TFCrashSafeKit
//
//  Created by zhutaofeng on 2019/5/22.
//  Copyright © 2019 ztf. All rights reserved.
//

#ifndef TFCrashSafeKitConst_h
#define TFCrashSafeKitConst_h

typedef NS_ENUM(NSInteger,TFCrashType) {
    TFCrashTypeNone = 0,
    TFCrashTypeNSArrayGet,
    TFCrashTypeNSArrayGetSubscript,
    TFCrashTypeNSMutableArrayGet,
    TFCrashTypeNSMutableArrayGetSubscript,
    TFCrashTypeNSMutableArrayAdd,
    TFCrashTypeNSMutableArrayInsert,
    TFCrashTypeNSMutableArraySet,
    
};

typedef NS_OPTIONS(NSUInteger, TFProtectType) {
    TFCrashSafeTypeAll = 1 << 0,
    TFCrashSafeTypeNone = 1 << 1,
    TFCrashSafeTypeKvo = 1 << 2,
    TFCrashSafeTypeTimer = 1 << 3,
    TFCrashSafeTypeUIThread = 1 << 4,
    TFCrashSafeTypeContainer = 1 << 5,
    TFCrashSafeTypeNotification = 1 << 6,
};

/**
 *  exemple :
 *  @property (nonatomic,  copy)NSString *string;
 *  tf_synthesize_category_property(string , setString,OBJC_ASSOCIATION_RETAIN_NONATOMIC)
 *
 *  tf_synthesize_category_property_retain retain属性
 *  tf_synthesize_category_property_copy copy属性
 *  tf_synthesize_category_property_assign assign属性
 *
 *  @param getter getter 方法名
 *  @param settter settter 方法名,不需要:
 */

#ifndef tf_synthesize_category_property_retain
#define tf_synthesize_category_property_retain(getter,settter) tf_synthesize_category_property(getter,settter,OBJC_ASSOCIATION_RETAIN_NONATOMIC,id)
#endif

#ifndef tf_synthesize_category_property_copy
#define tf_synthesize_category_property_copy(getter,settter)   tf_synthesize_category_property(getter,settter,OBJC_ASSOCIATION_COPY,id)
#endif

#ifndef tf_synthesize_category_property_assign
#define tf_synthesize_category_property_assign(getter,settter) tf_synthesize_category_property(getter,settter,OBJC_ASSOCIATION_ASSIGN,id)
#endif

#ifndef tf_synthesize_category_property_block
#define tf_synthesize_category_property_block(getter,settter,TYPE)   tf_synthesize_category_property(getter,settter,OBJC_ASSOCIATION_COPY,TYPE)
#endif

#ifndef tf_synthesize_category_property
#define tf_synthesize_category_property(getter,settter,objc_AssociationPolicy,TYPE)\
- (TYPE)getter{return objc_getAssociatedObject(self, @selector(getter));}\
- (void)settter:(TYPE)obj{objc_setAssociatedObject(self, @selector(getter), obj, objc_AssociationPolicy);}
#endif
/**
 *  exemple :
 *  @property (nonatomic,assign)CGPoint point;
 *  tf_synthesize_category_property_ctype(point,setPoint,CGPoint)
 *
 *  tf_synthesize_category_property_ctype
 *
 *  @param getter getter 方法名
 *  @param settter settter 方法名字
 *  @param CTYPE 数据类型
 *
 */
#ifndef tf_synthesize_category_property_ctype
#define tf_synthesize_category_property_ctype(getter,settter,ctype)\
-(ctype)getter{\
NSValue *associate_value = objc_getAssociatedObject(self, @selector(getter));\
ctype  value;\
[associate_value getValue:&value];\
return value;\
}\
-(void)settter:(ctype)value{\
NSValue *associate_value = [NSValue value:&value withObjCType:@encode(ctype)];\
objc_setAssociatedObject(self, @selector(getter), associate_value, OBJC_ASSOCIATION_ASSIGN);\
}
#endif



#endif /* TFCrashSafeKitConst_h */
