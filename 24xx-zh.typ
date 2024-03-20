// inline styling

#set text(
  8.5pt, top-edge: 9pt, luma(10%),
  font: ("Barlow", "Noto Sans CJK SC"),
  weight: 350, stretch: 87.5%,
  number-width: "tabular",
  lang: "zh", region: "cn", script: "hans",
)
#show regex("[A-Za-z0-9\s]+"): it => {
  show text.where(size: 8.5pt): text.with(9pt)
  show text.where(size: 7pt): text.with(7.5pt)
  show text.where(weight: 350): text.with(weight: 400)
  it
}
#show regex("[。．？！，、；：“”‘’『』「」（）【】［］〔〕【】—…~·《》〈〉/]+"): set text(font: "Noto Sans CJK SC")
#show "₡": set text(font: "IBM Plex Sans", stretch: 100%)
#show "➡": set text(7.5pt, font: "Noto Sans CJK SC")

#show emph: set text(rgb(37, 101, 136))

// block styling

#let leading = 3pt
#let top-edge = 9pt
#let line-height = leading + top-edge
#let block-spacing = line-height / 2 + leading

#set block(spacing: block-spacing)

#set par(leading: leading, justify: true)

#show heading.where(level: 1): set text(
  30pt, top-edge: 25.5pt, baseline: -1.5pt,
  weight: 500,
)
#show heading.where(level: 1): it => {
  set block(below: 4 * line-height - leading - text.top-edge)
  colbreak(weak: true) + it
}

#let marked(marker, gap, content) = context block(
  inset: (left: -(gap + measure(marker).width)),
  spacing: block-spacing,
  grid(
    columns: (auto, 1fr),
    column-gutter: gap,
    marker, content
  )
)
#show heading.where(level: 2): it => {
  set text(
    8.5pt, top-edge: 9pt, rgb(255, 47, 23),
    weight: 350,
  )
  marked(
    text(
      6pt, baseline: -0.75pt,
      font: "Noto Sans CJK SC",
      "▶"
    ),
    2pt,
    it.body
  )
}
#let design-note(text-fill: rgb(50, 165, 194), content) = {
  set text(text-fill, style: "italic")
  marked(text(tracking: -1pt, "//"), 2.5pt, content)
}

#set enum(numbering: "1", body-indent: 1em)

#let columns-full(count, body) = context {
  let line-height = measure("1").height + par.leading
  let line-count = calc.ceil(
    (measure(body).height + par.leading) /
    (line-height * count)
  )
  block(
    height: line-height * line-count - par.leading,
    spacing: block-spacing,
    columns(count, gutter: (100% - measure(body).width * count) / count, block(body))
  )
}

#let footer(body) = {
  set text(
    7pt, top-edge: 6pt, rgb(133, 142, 140),
    style: "italic"
  )
  set par(leading: 3pt)
  body
}

// document styling

#set document(
  title: "24XX 系统参考文档",
  author: ("Jason Tocci", "Paro")
)

#let page-margin = (
  x: (148mm - 8.5pt * 43) / 3,
  y: (210mm - line-height * 46.5) / 2,
)

#set page(paper: "a5")
#set columns(gutter: page-margin.x)

// ===================
// content begins here
// ===================

#set page(margin: 0pt)

#place(image("cover.png", width: 100%))

#let heading-line-1 = {
  set text(125pt, top-edge: 89pt)
  h(-6pt)
  text(stretch: 87.5%)[24]
  text(stretch: 75%)[XX]
  h(4.5pt)
}
#let heading-line-2 = {
  h(-1.5pt)
  text(
    18pt, top-edge: 22pt,
    "系统参考文档".codepoints().join(h(1fr))
  )
}

// Typst currently doesn't support blending modes
// so this is a rough emulation
#context block(
  width: 100%, height: 100%,
  inset: page-margin,
  fill: rgb(92.5%, 92.5%, 100%, 6%),
  block(width: measure(heading-line-1).width)[
    #set par(leading: 0pt)
    #set text(fill: rgb(70%, 70%, 100%, 22.5%))
    = #stack(heading-line-1, heading-line-2)
  ]
)

// page 1

#set page(
  margin: page-margin,
  columns: 2,
)

= 规则

*游戏*：玩家描述各自的角色要做什么。如果他们的行动不可能实现，需要付出代价，需要额外的步骤，或者带有风险，GM 应该告知。在确认行动之前，玩家可以调整计划，从而改变目标和赌注。只有想要_避免风险_时才需要掷骰。

*掷骰*：投一个_技能骰_——一般是 d6，有相关技能时会更高。如果被伤势或情势_阻碍_，就改为 d4。如果情势对行动有_帮助_，就多投一个 d6；如果有同伴_帮助_，那么同伴也投自己的技能骰，然后分担风险。取结果最高的骰子。

#grid(
  columns: (auto, 1fr),
  column-gutter: 0.5em,
  row-gutter: leading,
  [*1–2*], [*灾难。*你完整承受风险。GM 决定你是否成功。如果有死亡风险，你就死了。],
  [*3–4*], [*挫折。*承受减轻的后果或者只能达成部分成功。如果有死亡风险，你会受伤。],
  [*5+*], [*成功。*投得越高，结果越好。]
)

如果成功无法实现你的目的（“你开了枪，但它防弹！”），你至少会得到有用的信息或者建立优势。

*负重*：携带的物品量在合理范围内即可，但携带一件以上的_沉重_物品可能会阻碍你行动。

*提升*：每次任务后，每个角色可以提升一个技能（_无 ➡ d8 ➡ d10 ➡ d12_），并且获得 d6 信用点（₡）。

*防御*：被命中时，你可以描述你的一件物品_损坏_来把代价换成一个短暂的_阻碍_。_损坏_的装备在修好前都毫无用处。

*伤害*：伤害需要时间和/或医疗看护才能恢复。死亡时，尽快创建一个新角色加入游戏。参与度优先于真实性。

*GM*：不要用技能骰，而要从角色的行为、给玩家带来的风险和障碍等方面描述你的角色。带领大家设置游戏中不可越过的界限。用_快进、暂停、倒带/重做_等方式控制节奏，确保安全；并且鼓励玩家也这么做。提出你自己也不知道怎么解决的两难问题。不断转换焦点，让每个人都有表现的机会。有需要时，掷骰决定是否该有坏运气（例如用完了弹药，或者碰上了守卫）——投一个骰子决定是有（1–2）麻烦，还是（3–4）麻烦的征兆。用即兴裁决填补规则中的空白；休息时，和玩家一起回顾不够好的裁决。

= 角色

#design-note[像这种用双斜杠开头的段落是 SRD 设计注释。其它段落都是面向玩家或 GM 的文本。]

#design-note[角色的初始技能提升和物品所值的信用点数之和大约为 6，其中可以包括来自“专业”和“起源”的技能（“起源”也可以用“3 项技能提升”代替）。]

== 选择你角色的*专业*。

*露面*：擅长_读懂他人_（d8）和_欺骗_（d8）。拥有一个_种类齐全的易容衣柜_。

*蛮力*：擅长_威吓_（d8），以及_近战_（d8）或者_射击_（d8）。拥有一把_剑_，_枪械_或_义手_。

*灵能*：擅长_心灵感应_（d8，感知浅层思维）和_念动术_（d8，力量和你的手臂一样），或者选择其一提升到 d10。拥有_一瓶灵能爆发_（增幅灵能力，有成瘾性）。

*医疗*：擅长_医药_（d8）和_电子_（d8）。拥有一个_医疗包_和一套_义体手术工具_（_沉重_）。

*潜行*：擅长_攀爬_（d8）和_隐匿_（d8）。拥有一套_攀爬装备_和一副_夜视眼镜_。

*科技*：擅长_骇侵_（d8）和_电子_（d8）。拥有一套_修理工具_和一台_定制电脑_（_沉重_）。

== 选择你角色的*起源*。

*外星人*：编 2 个特征，例如_电流_、_翅膀_、_天生迷彩_、_六条肢体_。

*仿生人*：你有一个准备好升级的仿生身体。选择_合成皮肤_（看起来像人类）或者_外壳_（防御时可以无害地损坏）。提升一个技能。

*人类*：获得 3 个技能提升（从_无技能 ➡ d8 ➡ d10 ➡ d12_）。你可以选择新技能，也可以提升已有的技能。

== 选择或者编造起源给予的*技能*。

攀爬，社会关系，欺骗，电子，引擎，爆炸物，骇侵，近战，威吓，体力劳动，游说，驾驶，奔跑，射击，太空行走，隐匿，追踪

#design-note[如果角色的初始技能比这更宽泛，那么应该减少其数目，或者使其没那么有用。]

// page 2

= 装备

#design-note[如果一件物品比一台新游戏主机还便宜，那么唯一的开销就是取得它的时间。]

== 你有一部*_通讯器_*（手机）和 ₡2。大多数物品和升级每个价格 ₡1。忽略一把小刀和一顿饭之类的不到一信用点的交易。

*护甲*：_防弹背心_（可以损坏一次作为_防御_），_战斗护甲_（₡2，_沉重_，最多损坏 3 次），_动力甲_（₡3，_沉重_，最多损坏 3 次，真空级，磁力靴）。

*义体*：_义耳_（升级有_回声定位、语音压力检测器_），_义眼_（升级有_红外视觉、望远视觉、透视_），_义肢_（升级有_迅速、强力、储物仓、植入工具或武器_），_颅后接口_（升级有_感官数据备份、技能提升_），_纳米治疗机器人，毒素过滤器，变声器_。

*工具*：_火焰喷射器（沉重），低重力喷气背包，医学扫描器，迷你无人机，修理工具，侦察工具包_（攀爬工具、信号枪、帐篷；_沉重_）。

*武器*：_手榴弹_（4 枚，可以是_破片榴弹、闪光弹、烟雾弹_或 _EMP（电磁脉冲）榴弹_），_手枪，步枪（沉重），霰弹枪（沉重），电棍，麻醉枪_。

== *飞船*都带有以下功能的基础版本；每个升级花费 ₡10。紧急情况下，玩家选择一个行动来实施或者_帮助_。

*通讯器*：升级有_窃听器、干扰器、快子喷流_（恒星系内消除延迟）。

*船只*：自带_逃生舱_。升级有_战斗机、穿梭机_（可重入大气层）。

*引擎*：支持超光速跃迁和亚光速航行。升级有_增大跃迁距离、加快航行速度、提高机动性_。

*设备*：自带全体船员的_真空服_。升级有_军械库、重型装载机、挖矿装备、缆绳_。

*船体护甲*：_防御_时可以无害地损坏。升级有_可重入大气层、遮阳罩_。

*传感器*：升级有_深空探测、生命迹象扫描、行星勘测、战术舰艇扫描_。

*武器*：自带自动炮台。升级有_激光切割器、军用级炮台、鱼雷_。

= 细节

#design-note[额外的角色和设定细节通常需要针对具体设定定制（尤其是涉及到外星人和时尚）。下面的选项可以随意取用，它们应该能用到很多科幻设定里。]

== 编造或骰出*个人细节*。

*姓氏*

#columns-full(4)[
  + 艾克
  + 布莱克
  + 克鲁兹
  + 达拉斯
  + 恩格尔
  + 福克斯
  + 吉
  + 哈克
  + 艾耶
  + 约什
  + 卡斯克
  + 李
  + 莫斯
  + 纳什
  + 帕克
  + 卡迪尔
  + 辛格
  + 特兰
  + 上田
  + 郑
]

*绰号*

#columns-full(4)[
  + Ace
  + Bliss
  + Crater
  + Dart
  + Edge
  + Fuse
  + Gray
  + Huggy
  + Ice
  + Jinx
  + Killer
  + Lucky
  + Mix
  + Nine
  + Prof
  + Red
  + Sunny
  + Treble
  + V8
  + Zero
]

*举止*

#columns-full(2)[
  + 战战兢兢
  + 审时度势
  + 直率
  + 忧心忡忡
  + 沉稳
  + 随意
  + 冷漠
  + 好奇
  + 表现欲强
  + 拘谨
  + 迟钝
  + 真诚
  + 正经
  + 温和
  + 天真
  + 万事通
  + 易怒
  + 鲁莽
  + 简截了当
  + 厌烦
]

*飞船名*

#columns-full(2)[
  + 亚里安号
  + 黑杰克号
  + 卡鲁奇号
  + 金丝雀号
  + 奇想号
  + 机遇号
  + 飞鱼号
  + 福龙号
  + 公路之星号
  + 登月号
  + 摩根斯坦恩号
  + 凤凰号
  + 游集号
  + 无休号
  + 银光号
  + 星尘号
  + 逐日号
  + 雨燕号
  + 雷霆之路号
  + 旅人号
]

// back page

#set page(
  margin: (
    top: page-margin.y - block-spacing,
    bottom: page-margin.y + line-height * 3.5
  ),
  footer-descent: 15pt,
  footer: footer[
    *译注*：翻译绰号超出了译者的能力范围。“黑杰克”（Blackjack）即纸牌游戏二十一点，但“二十一点”不适合作飞船名。“卡鲁奇”（Caleuche）是智利南部原住民马普切神话中的一艘幽灵船。

    版本 1.41.typ.2 • 文本、排版和 24XX logo 均 CC BY Jason Tocci • 美术 CC BY Beeple (Mike Winkelmann) • 中文翻译 CC BY Paro
  ]
)

#place(hide[= 封底])

#block(
  fill: rgb(37, 101, 136),
  inset: (bottom: line-height),
  outset: (x: 7pt, top: 15pt)
)[
  #set text(white, style: "italic")
  #text(tracking: -1pt, "//") *开端*：解释设定的基本要素。如果在其它地方还没有解释清楚，那么给出一个让角色团结起来的理由，并且提示角色应该把大部分时间用在什么活动上。
]

#design-note[*封底*：如果你想模仿这个 SRD 背后的一系列微型 RPG 的风格，这个封底（或者一张信纸尺寸的白纸的一面的左半边）能放下四张 20 个条目的随机表。GM 可以用这些表格为一场即兴游戏生成灵感，比如：“[姓名] 雇了你在 [地点] 执行 [任务]，但有个 [转折]！”下面有一个范例随机表。]

#design-note[*补充规则*：这个 SRD 非常简短，这是希望有经验的 RPG 玩家能大胆填补其中的空缺，而 RPG 新人则不会有太多先入为主的观点。所有模糊之处都是有意供开放解读。（例如：你能在一次掷骰中同时获得来自同伴和情势的帮助骰吗？这由你决定！）可以按需扩展或澄清规则。我自己引入新规则的原则是尽可能减少加减计算，避免太多记账工作（考虑到已经要记录信用点、阻碍、沉重物品的数量，还有哪些物品损坏），尽量选用含义显而易见或者模糊得诱人的词汇。]

== *投 d20 生成一个联系人、客户、对手或目标。*

+ 阿尔钦博托，古怪的科技商人兼工匠
+ 极光，富有的独特物品收藏家
+ 熄灯人，安静的证据清除专家
+ 漂白者，看护仿生人转变成的讥讽的刺客
+ 布朗，有一只金属手臂的阴沉的警卫队长
+ 子弹，严肃的仿生人军火贩子
+ 外卖员，有一双飞快义腿的狂妄信使
+ 渔人，正在热切地寻找队员的街头小子
+ 参，关爱世人的毒品贩子
+ 红人，极其谨慎的销赃人
+ 凯撒，穿着银色西装，爱咧嘴笑的放贷人
+ 奥西里斯，疲惫的街头外科医生
+ 粉蓝，出价慷慨的仿生人中间人
+ 雷彻，严厉的雇佣兵战术小队队长
+ 犀牛，愚钝而慷慨正直的保镖
+ 山姆，容易被害的勇敢记者
+ 变速箱，卖力的地下拆车厂主
+ 分眼，高效的情报贩子
+ 吹哨人，微笑的出租车/接头车司机
+ “X”，为不知名公司服务的冷静的中间人

== *投 d6 找一个任务。花费 ₡1 重骰。*

#grid(
  columns: (auto, 1fr),
  column-gutter: 0.5em,
  row-gutter: leading,
  [1–2], [没找到。要想有任务就得欠别人点东西。],
  [3–4], [找到了一个任务，但有哪里不对。],
  [5-6], [有两个任务可供选择。]
)

#v(6pt)

#design-note[*寻找任务*：许多团队不需要为了获取报酬而找工作（比如军事单位）。不过，如果你的游戏确实采用了这种安排，那么危险的任务应该有更多回报，这样才付得起那些用来医疗，修理、更换损坏的装备，重骰坏任务，以及熬过找不到任务的空窗期的 1–3 信用点的“开支”。另外，上面这张表中的“欠别人点东西”这个短语被有意模糊化了。或许值得将其澄清或引申到其它方面（比如把一个放贷人加进你的“联系人”表）。]

#design-note[*任务*：任务（或者情景等）的列表应该针对你的设定定制，并且要能引出让每个角色的技能都用得上的场景。常见的任务模板有“解决一个罕见的威胁”“调查某个难以解释的东西”和“为某人从某地取得一件物品”。它们起着“可玩设定”的作用——既要包含能暗示游戏设定的元素，又要能直接用在游戏中。]

#design-note(text-fill: rgb(50, 145, 73))[*授权协议*：这个 SRD 以 Creative Commons Attribution 4.0 协议（#underline[CC BY 4.0]）发布。你可以在你自己的游戏里随意使用这里的文本和排版，前提是你遵从这些要求：]

#design-note(text-fill: rgb(50, 145, 73))[注明作者：看到这一页底下的小字了吗？那就是我用来塞下版本号和第三方内容（比如封面美术）的署名的地方。你也可以把它放在你游戏里的其它位置，但一定记得写这么一句——比如：“24XX 规则由 Jason Tocci 以 CC BY 授权。”]

#design-note(text-fill: rgb(50, 145, 73))[用 24XX，别用 2400：你可以说你的游戏“与 2400 兼容”或者“可用于 2400”，但请不要直接使用来自 2400 的材料，或者把你的游戏命名成像是我的 2400 系列的一部分一样（除非你得到了我的明确允许）。]

#design-note(text-fill: rgb(50, 145, 73))[拒绝偏见：请不要在任何宣扬或者纵容白人至上主义、种族主义、厌女、歧视残疾人、恐同、恐跨，或者其它对边缘群体的偏见的产品中使用来自这个游戏的任何文本、24XX logo 或是我的名字。]
