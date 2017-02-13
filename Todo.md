1: 投票主体: item
    id(int):
    title(string):
    info(text):
    avatar(string):
    type(small_int): wechat | weibo
    category_id(int)
    count(redis counter)

2: 主题所属：category
    id(int):
    name(string):

3: 投票人: user
    id(int):
    openid(string):
    item_ids(redis sets) 

4: item 浏览次数
    hit(redis counter)

5: category 浏览次数
    hit(redis counter)

6: 开关
    open(redis value)