# 主要目的: Emacs learning(org-mode) ---Emacsable
次要目的: clojure(closure) learning ----Clojureable

    Use your force, make it reachable(reference--relationship), Zhao!

能为他人创造点价值，那是最好的feedback([故事编程story programming][300])

Okay , it comes from flyingmchine,
I have test in the two systems windows10
and ubuntu, all valid for newer.

参考我写的[emacs安装教程 for ubuntu and windows][39]

[原始记录版本][86]

*注意，[标题55][149]引入了flyspell问题，所以在windows得安装aspell,这个错误会在
0调用org-agenda的时候出现(本质是调用flyspell mode失败)*

*注意，添加 (set-language-environment "utf-8")到init.el,这样新文件才会是utf-8编码风格*

*注意，在[标题66][150]我引入了org-crypt，所以安装了gnupg-win-3.0,得按照说明在你的电脑上安装，才可以具备加密功能(如果不加密不影响使用)*

``` org
慎重加密！防止丢失
```

C-c [a-z] and F5~F9是专门预留给用户自定义快捷键的，所有的major和minor都应该遵守这一规范。
[key-binding-convention][45]


## 当前.emacs.d安装和使用方法

又重装了一次window10系统，按照下述过程安装对应plugins,可直接使用(clojure项目的C-c Alt+J也没问题，正常的切换空间C-c Esc n)
注意修改[custom.el][184]。

1. 打开git bash，` git clone https://github.com/jueqingsizhe66/ranEmacs.d` 下载当前配置包，
windows放在`C:\Users\用户名\AppData\Roaming`，linux系统放在~目录下即可。因为init.el存在很多当前
系统的custom-face-variable信息，所以需要下载后将其删除对应expression的信息
2. 下载emacs工具 ，[emacs25-3.1][161]
3. 下载gnupg软件，[gnupg-for-win][162],配置相关密匙即可，进一步参考[标题66][150]
4. 下载aspell 软件，已经在customization目录下，解压缩到`C:\Program Files (x86)\Aspell`即可，Aspell下一级目录为bin，data等，已包含对应字典(所以windows很方便),注意aspell的配置信息存放在.orgConf.el中。
5. clojure配置
   * 安装[java-se-9.0.1开发包][163] 
   * 搜索leiningen或者boot-cli，当前搜索[leiningen][164],并安装对应的lein.bat
   到`C:\Windows\System32`,然后执行`lein self-install`即可,进一步可以参考我写的[emacs和clojure安装教程For ubuntu和windows][39]
6. 然后再配合[totalCommander][166],可以使用emacs快速打开window文件(server+client模式),在选项中--Edit/view(Editor for F4)设置打开的模式为emacsclientw即可(注意解压totalcommand破解文件到安装目录覆盖即可)。同时
带上[everything][167]比较好，这样就构成一个比较好的系统了。[标题84][177]
TotalCommander还有一个好用的地方，配合上`Ctrl-d`快速定义存储文件夹下，然后可以`Cmd`、`Gvim readme.md`等等命令流操作，很方便(
相比较于win+R-->cmd--->cd 工作路径--->然后执行相应的动作来说，tc帮你做了工作流的简化,由此说上一声伟大的totalCommander也不为过!)
7. 在使用`C-x C-f`需要设置一下你的项目目录，在custom.el对应修改一下，默认是我电脑上的`E:/clojure-home`是不对的。

截止到2017.11.19所用到的配件都在[emacs百度云][165],方便大家使用。另有一本the joy
of the clojure电子书.

8. something wrong? like below
```
Debugger entered--Lisp error: (error "Font not available" #<font-spec nil nil Source\ Sans\ Pro nil nil nil nil nil nil nil nil nil ((:name . "Source Sans Pro") (:user-spec . "Source Sans Pro"))>)
  internal-set-lisp-face-attribute(org-document-title :font "Source Sans Pro" #<frame emacs@DESKTOP-MKS6PSV 00000004008cd970>)
  set-face-attribute(org-document-title #<frame emacs@DESKTOP-MKS6PSV 00000004008cd970> :inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro" :height 1.5 :underline nil)
  apply(set-face-attribute org-document-title #<frame emacs@DESKTOP-MKS6PSV 00000004008cd970> (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro" :height 1.5 :underline nil))
  face-spec-set-2(org-document-title #<frame emacs@DESKTOP-MKS6PSV 00000004008cd970> (:inherit default :weight bold :foreground "#b2b2b2" :font "Source Sans Pro" :height 1.5 :underline nil))
  face-spec-recalc(org-document-title #<frame emacs@DESKTOP-MKS6PSV 00000004008cd970>)
```

you can debug it  , `runemacs.exe --debug-init`

solution:

```
just remove the custom-set-variables info about the font please,  sorry for bothering you!!
```

9. 常用文件夹
在setup_emms.el配置了默认音乐文件夹位`H:\Classical` ,每个系统不同需要改一下

在scheme-editing.el 配置了chezscheme路径，也需要修改一下。

10. graphviz

<2018-05-03 00:19> 后来我发现，如果没有安装graphviz到系统【指的是在path路径能够找到dot】,会报错误，详细看[标题65 org-mind-map][240]

### 1.为了引入clj-refactor(一个好用的补全包的工具)

click [clj-refactor][2]

1. M-X package-install clj-refactor(感觉每次得装上2遍)
然后在setup-clojure.el添加配置代码

```
(require 'clj-refactor)

(defun my-clojure-mode-hook ()
    (clj-refactor-mode 1)
    (yas-minor-mode 1) ; for adding require/use/import statements
    ;; This choice of keybinding leaves cider-macroexpand-1 unbound
    (cljr-add-keybindings-with-prefix "C-c C-m"))

```

太喜欢emacs的查找替换功能， 首先选择一块区域，输入`s`,然后按照vim的`s///`的方式进行替换，还会出现替换后的效果，做的很人性化! <2018-07-25 14:50>
### 2.为了使用类似nerdtree的neotree(ui.el)【已删除】

click [neotree][3]，不常用!使用ivy-counsel即可 参考标题91.

click [all-the-icons][4]
1. 在init.el添加了 
```
     neotree
     all-the-icons   ;;;you need to download fonts
```

注意，在第一次使用时候，执行`M-x  all-the-icons-install-fonts`,会提示安装字体，不然
打开neotree会出现部分无法显示。

在lisp系语言，注意下列四种风格的括号

- open/close parentheses
- square braces
- curly braces
- angle braces

两种引号

- double quote
- single quote

2. 并且在ui.el添加了
```

(require 'neotree)
(global-set-key [f6] 'neotree-toggle)
(require 'all-the-icons)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))


```




### 3.增加了一些其他插件

放在了init.el
[auto-complete][10]

[dracula-theme][11]

[hlinum][7]

[which-key][6]

[restclient][8]

[browse-kill-ring][9]


对应的auto-complete(editing.el)配置如下

```
;; init auto-complete
(require 'auto-complete-config)
(ac-config-default)


```
对应的dracula-theme(ui.el)配置如下
```
(load-theme 'dracula t)
;; workaround blue problem https://github.com/bbatsov/solarized-emacs/issues/18
(custom-set-faces
(if (not window-system)
  '(default ((t (:background "nil"))))))

```

对应的which-key(ui.el)和hlinum(editing.el)配置如下
```
;; set up some useful mode
(which-key-mode)


(require 'hlinum)
(hlinum-activate)
(set-face-attribute 'linum nil :background nil)
(set-face-foreground 'linum "#f8f8f2")
(setq linum-format "%d ")
;; (set-face-attribute 'hl-line nil :foreground nil :background "#330")
(set-face-attribute 'hl-line nil :foreground nil :background "#353535")

;; 2017/7/13
(browse-kill-ring-default-keybindings)


```

### 4. 修正rainbow(editing.el)

```
;; yay rainbows!
;;(global-rainbow-delimiters-mode t)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

```

### 5. expand-region(editing.el)

Seen from [emacs-rocks-9][40]

click [expand-region][12]
```
;; init expand-region
(require 'expand-region)
(global-unset-key (kbd "M--"))
(global-set-key (kbd "M-=") 'er/expand-region)
(global-set-key (kbd "M--") 'er/contract-region)


```

可以快选择。

### 6. bookmark

click [bookmark+][15]

快捷键(对了数字键盘8直接打开，数字键盘7打开,可查看[ui.el][185])
```
c-x r l : 查询bookmark
c-x r m : 添加
c-x r b : 跳转
```

### 7. org-mode(what is the writing style of org-mode?)

[特详细的org-mode教程][13]

[GTD Workflow][14]

常用快捷键

```
Tab打开标题

查找:--------
    c-c c-n 光标沿标题方向向下移动
    c-c c-p 光标沿标题方向向上移动
    c-c c-q 添加标题的tag
    c-c a 打开agender
    c-c c-t 添加当前标题的todo
    c-c c-d 添加当前标题deadline
    c-c c-s 添加当前标题的schedule
    <s Tab 添加src块(由于136 wrapper-region的引入，所以可以使用`Ctrl-+`的方式，结核以下动作`#e #s #q` <2018-08-03 15:52>)
    <e Tab  添加example快

    c-c shift-< 打开calendar
    c-c shift-> 添加calendar鼠标下的日期
    
    
    C-c *  从普通文字切换到标题 <2018-09-04 23:36>
    C-c -  从

修改：------

    M-RET 插入同级列表项(插入一个同级标题 <2018-04-23 17:41>)
    M-S-RET 插入有 checkbox的同级列表项(<2018-02-05 14:26> 再次用于工作中 <2018-05-03 05:49> 一个标题下插入列表，标题上使用[%]或者[/])
    C-c C-c 改变 checkbox状态
    M-left/right 改变列表项层级关系
    M-S-left/right 将子树升降级
    M-S-up/down 将子树上下移
    M-up/dowm 上下移动列表项

    输入C-c . 会出现一个日历，我们点选相应的时间即可插入(现在一般用M-x today)。

<2018-04-26 23:59> M-x undo-tree-visualize(C-x u) 表示打开当前文件的undo tree，可以按照需要进行恢复，特别方便！！
<2018-05-03 19:56> C-x k 删掉buffer ,在  C-x b切换buffer, C-x C-b 出现一个buffer列表

C-c b 扫描所有的org文件！！！！【有用！】
```


注意，在标题上面或者总任务上面的尾巴添加上[%]或者[/]即可，emacs org-mode会自动进行计算任务的[总进度][87]。
只有在任务list才能添加勾选checkbox，标题不添加(操作方法，写上1.然后Alt+Shift+Enter, 既可以添加checkbox, 添加done标签标示完成 或者C-c C-c <2018-05-22 23:07>)。

标题加上任务状态(doing或者todo或者pending才会在大标题的统计中显示出来，否则子标题不会出现在父标题的统计状态下),
然后在小标题里面再填写任务的各个状态[checkbox]，标题没有checkbox，只有标题tag、任务状态、标题权限,三种属性!父标题
统计子标题状态，一定得添加任务状态! <2018-08-01 10:50>

### 8. chez-scheme的集成(scheme-editing.el)

注意你的scheme路径，参考 [emacs][16]
```

(require 'cmuscheme)
(setq scheme-program-name "E:\\ChezScheme\\a6nt\\bin\\a6nt\\scheme")         ;; 如果用 Petite 就改成 "petite"

```

打开ss,scm,rkt结尾的文件即可执行F5和F7(其他文件未绑定)


Okey, below is the new interface,

![image][1]


### 9. cua mode(deleted)
本来想着配置[cua(Common User Access) mode][18],后来想着ctrl-v和传统的kill-ring 冲突，于是就把它删掉，
而且传统的[kill-ring][17] 队列的风格也是不错。

当前的配置文档使用M-y就可以调用(注意ctrl+y表示黏贴 M-W表示添加到黏贴板)
(browse-kill-ring-default-keybindings),这样可以看到所有删除和剪切的历史，
通过多次摁M-y可以切换不同的历史(还得多熟练),查看editing.el最后一行。

### 10. 想着安装上markdown-mode+(major-mode)

```
M-x package-install  markdown-mode+
```

在init.el的my-package list 增加markdown-mode+，这样每次打开markdown的md后缀结尾的后缀名就会自动渲染，这也是emacs的[mode][18]的一种运用.
xs
1. `shift+tab`切换overview视图(标题间的outline模式)(第一步:Shift-tab多次，进入outline模式)
2. `M-x markdown-cycle` 可以逐步children化，这样你就可以只工作在某一级别下(第二步:`M-x markdown-cycle` 不断进入子目录
3. `Alt-n|p`上下移动标题

当然说到底还是emacs的shift+tab切换效率高些！ 参考标题139

![markdown-shifft][358]
### 11. server+clinet

emacs经常地使用方式是
   
     长时间打开server(通过runemacs daemon，并敲入M-x server-start)
     然后就可以在ubuntu系统的命令行使用emacsclient 文件名
     或者 windows系统的TotalCommander通过emacsclientw(相比于emacsclient,他能够直接跳转到serve断)查看文件，这样打开的文件
     就会出现在server端的屏幕上，使用ctrl+x #来关闭

这样启动emacs方便些。

现在在配置文件init.el增加了(server start) 这样就不需要每次runemacs daemon的时候还需要启动server。

<hr/>
<hr/>
到目前位置，ubuntu和windows的配置能够同时使用！！！Excellent!

![new Pic][19]


### 12. info window

类似于vim的help系统，emacs的info系统也做得很强大，

使用 `C-h i` 可以得到一个info window, 一个不错的帮助平台（结合标题19进行学习）

1. 使用space键执行翻屏(scroll one screen at a time)
2. [ and ] Previous /Next node
3. 使用n和p跳转上下章节(同级目录跳转）(Previous/next sibling node)
4. l and r可以返回和向前跳转(in history)(l and r go back /forward in history)
类似于浏览器的回退和前进
5. Tab 表示在links之间跳转
6. Enter进入链接, m 弹出一个prompt minibuffer, for a menu item name to choose it.
7. q 推出info browser

        Everyday reading
        For everyday reading, you want SPACE for browsing and reading 
        as it "does what you want". It thumbs through a page until it
        reaches the end. Then, it either picks the next sub node or the
        next chapter. For browsing ,use [ and ] to cycle back and forth
        through nodes.


在`c-h i` 具有menu的文档下，可以输入`m` 命令得到menu菜单，执行定义到某个manual下，
常用的组合过程`c-h i m`

`C-h F` 函数说明`M-x describe-function`

`C-h V` 变量说明`M-x describe-variable`

`C-h a` 打开apropos symbol的regex字符关联的系统说明

`C-h d` 类似于apropos的regex字符关联的系统文档

`C-h k` 查看绑定快捷键的说明，比如你想查看`C-x #`表示什么意思，就可以执行该命令(在你的vim中可以使用`:map <vao>`

### 13. mode helper system

使用`C-h m`等效于`M-x describe-mode` 可以很方便打开当前的buffer后缀对应的major-mode的帮助信息(一般一个
文件后缀对应一个major-mode和多个minor-modes)

比如在打开的markdown md后缀文件下，会打开markdown major-mode的帮助信息，有相关的
快捷键等帮助信息

<2017-12-10 01:27> 回头看看他还是挺有用的

由于有了projectile所以现在一般用`F1 m`,`F1 k`等

### 14. 多窗口

C-x 5 2 打开当前window相同的frame
如果关掉当前frame，执行`C-x 5 0` 
如果关掉其他frame，执行`C-x 5 1` 

`C-x 1` delete other windows.
`C-x 2` split window below.
`C-x 3` split window right.
`C-x 0` delete the actie window right.

<2018-08-03 15:53> 配合上ace-window,`M-o`在两个窗口下，代表toggle跳转(跳转来跳转去),而在3个以上时，则会添加数字标签窗口，输入数字进行跳转!

### 15. 括号相关的跳转(paredit-mode)

`C-M-d`  Move down into a  list

`C-M-u`  Move up   out  of a list

`C-M-n`  Move forward to the next list

`C-M-p`  Move backward to the previous list

`C-M-a`  Move to beginning of defun

`C-M-e`  Move to end       of defun


### 16. multiple-cursors(editiing.el)(再次学习)(删掉，使用evil-mc)

Seen from [emacs-rocks-13][37]

#### 函数名

1. mc/mark-next-like-this （C->)
2. mc/edit-lines (C-S-c C-S-c 标记M-h区域)
3. mc/mark-previous-like-this(C-<)
4. mc/mark-all-like-this (C-c C-<)


<2018-07-25 14:52>替换为如下形式，来自[ abrams ][354]
```
(use-package multiple-cursors
  :ensure t
  :bind (("C-c M-. ."   . mc/mark-all-dwim)
         ("C-c M-. C-." . mc/mark-all-like-this-dwim)
         ("C-c M-. n"   . mc/mark-next-like-this)
         ("C-c M-. C-n" . mc/mark-next-like-this)
         ("C-c M-. p"   . mc/mark-previous-like-this)
         ("C-c M-. C-p" . mc/mark-previous-like-this)
         ("C-c M-. a"   . mc/mark-all-like-this)
         ("C-c M-. C-a" . mc/mark-all-like-this)
         ("C-c M-. N"   . mc/mark-next-symbol-like-this)
         ("C-c M-. C-N" . mc/mark-next-symbol-like-this)
         ("C-c M-. P"   . mc/mark-previous-symbol-like-this)
         ("C-c M-. C-P" . mc/mark-previous-symbol-like-this)
         ("C-c M-. A"   . mc/mark-all-symbols-like-this)
         ("C-c M-. C-A" . mc/mark-all-symbols-like-this)
         ("C-c M-. f"   . mc/mark-all-like-this-in-defun)
         ("C-c M-. C-f" . mc/mark-all-like-this-in-defun)
         ("C-c M-. l"   . mc/edit-lines)
         ("C-c M-. C-l" . mc/edit-lines)
         ("C-c M-. e"   . mc/edit-ends-of-lines)
         ("C-c M-. C-e" . mc/edit-ends-of-lines)
         ("C-M-<mouse-1>" . mc/add-cursor-on-click)))

```


在没有[multiple-cursors][21]的前提下，你也可以使用`C-x r t` 来标记当前
光标前的所有行，当作一个矩形区域，然后可以多行编辑


#### C-x r t使用技巧

1. 首先确定一个字母对角线起点
2. 然后确定一个字母对角线终点，进而构成一块矩形区域
3. 输入你要替换的string，比如把所有变量类型从float替换为double等





当然你也可以使用`C-x Space Esc Down Down `(down必须向上或者向下箭头)等操作来标记多行

而有了multiple-cursors, 你现在可以配合`M-h` 选择一个段落，然后`C-S-c C-S-c`

或者你可以使用`C->` 来mark当前光标下单词，并查找下一处出现的地方，最终摁下`Enter`
键，表示确认
。

<2017-11-01 19:26> add below readme:

```
注意配合上M+= 选择区域，然后选择C->逐个向下选择，或者c-<逐个向上选择
亦可以C-c C-<全部选择当前的选择快相同的单元

如果没有配合上M+=,则C->表示选择下一行，C-<表示选择上一行(比较少用，也比较没用)。
```

较常用的命令，`M-x mc/mark-all-words-like-this`

#### 使用技巧


1. To get out of multiple-cursors-mode, press `<return> or C-g`. 
The latter will first disable multiple regions before disabling multiple cursors.
If you want to insert a newline in multiple-cursors-mode, use `C-j`.
2. `C-c M-. M-.` or `C-c M-. C-a` 都是全选所有相同的symbols(只是mark而已,当然也支持中文)，然后执行动作比如`c`修改，`d`删除等
最经常的情况是针对相同的word进行修正, 而且有时候需要快速产生一个列表
也是很简单，先逐个罗列列表信息，然后自动产生数字和字母即可（用下面的insert技巧)
列表只是方便读者看！写作者可以不需要也可以！(<2018-08-01 09:55>有道理!)
3. 快速插入数字, `mc/insert-numbers`或者字母`mc/insert-letters`(在每行牵头
4. 哈哈！！`C-M-鼠标左键` 表示`mc/add-cursor-on-click` 很方便定义多个位置


体味到了mark的思想(visual状态), 以及批处理的感觉！

First mark, and then add cursors.

<2018-09-27 00:59> However ,there are [some issues][428] in the evil-mode for multiple-cursors
然而evil-mc-mode基本上可以解决问题

工作流第一步选择单词(然后才会进行mark)

1. 选择功能:(第一步)

`g r m` 三个组合字母进入多cursors模式, `C-n 和C-p`支持向上选择和向下选择(完全等同于vim的操作方式)
`g r h` create a cursors here
`g r j` 表示向下行插入cursor
`g r k` 表示向上行插入cursor

2. 切换功能:

`g r f` 调到第一个mark cursor, `g r l` 跳到最后一个
`C-t` 很重要就是去掉选择作用，去掉mark cursor(类似于`g r p`和`g r n`)

3. 退出功能
`g r u` 三个组合字母退出多cursors模式(finally,工作流的最后一步

很多其他的工具命令都是跳过不跳过，mark不mark的关系

in short, `C-n / C-p` are used for creating cursors(because of what to create cursor? ), and `M-n / M-p` are used for cycling through cursors

于是改用evil-mc mode

额外的[evil-mc-extras][429],增加了当前光标数字自动增加

1. gr+ `evil-mc-inc-num-at-each-cursor`
2. gr- `evil-mc-dec-num-at-each-cursor`

配合行插入`g r j`和`g r k`即可实现快如插入1，2，3. 实现插入1，然后使用`gr+`使得递增。

### 17. vim-surround to evil-surround

有时候需要给单词或者字段组合增加个双引号或者单引号， 亦或者括号，
在emcas可以使用[evil-surround][22](vim中使用[vim-surround][23])

add `(global-evil-surround-mode 1)` in the editing.el

add `evil-surround` into my-package list

### 18. mo-git-blame and ivy

### 函数名

1. ivy-resume
2. counsel-M-x
3. counsel-find-file
4. counsel-describe-variable
5. counsel-find-library
6. counsel-info-lookup-symbol
7. counsel-unicode-char
8. counsel-ag
9. counsel-locate
10. counsel-rhythmbox
11. counsel-expression-history
12. counsel-git-grep
13. swiper

我见过比较好的[git教程][84]

git配置

*注意，默认的windows git 目录是在 c:/users/username/AppData/Roaming/.gitconfig *

click [magit][5]
```

;; set up some useful mode
(which-key-mode)

;; magit
(global-set-key (kbd "C-x g") 'magit-status)


<2018-05-03 13:25> 在magit的log view中可以使用 l来进行界面的更改
```


阅读[emacs教程][25]安装了git blame
git blame 安装
ivy ivy-dired-history all-the-icons-ivy ivy-rich

[ivy][27]是一个类似[emacs helm][28]的东西，可以方便查找buffer和file，

快速显示当前文件中包含函数的方法，`C-s (defun`等,思路都是类似的，只不过好点的可能就是把函数名也提取出来。
[Ivy][27], a generic completion mechanism for Emacs.
[ Counsel ][316], a collection of Ivy-enhanced versions of common Emacs commands.i
[ Swiper ][317], an Ivy-enhanced alternative to isearch.



```
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
```


*注意可以继续使用C-s搜索上一次内容，如果你执行C-s C-w那么就会搜索当前光标下的单词，如果C-r则是反向执行*

我现在都是使用`M-x swiper` `M-x-git` `M-x counsel-find-file`

`M-x counsel-find-library` `M-x counsel-git` 来做实验，看看速度怎么样，
发现`M-x counsel-git-grep`速度很慢，没必要用~ `M-x swiper` 搜索buffer，vim的
对应功能是[vimfiler][25],挺好用的!

[ivy使用手册][26]

于是现在也在navigation.el增加了ivy-mode.

### 19. 改进org-mode配置

org-mode organize your life into plain text(朴素的文字形势)

在.orgConf.el中添加的正确org-capture-templates，使用快捷键`C-c c`来捕捉你的想法并进行记录。 org-remember打算删掉。

有趣的大纲查看命令 
`C-c \`

有趣的添加当前日期命令
`C-c .`

在查看org-agenda 的时候可以使用`v`来选择你要看的日、月、年视图等

有趣的org帮助 `LINK:info:org:Top`.(鼠标左键点击或者C-c C-o) 
在该模式可以学到很多有趣的knowledge,比如你可以使用`g`进行跳转, 其实就是emacs强大的info系统，`C-h i`或者`F1 i`


为了显示clean的org文档，在.org.conf添加了
`(setq org-startup-indented t)`

为了显示图片，在.org.conf 添加了
`(setq auto-image-fill-mode t)`

### 20. add calendar and bookmark shortkey

##### 函数名:

1. calendar
2. list-bookmarks



edit the ui.el, and add the below information,and also add the
cal-china-x农历信息

```

;; in the digital keyboard add calendar and bookmark
(global-set-key [kp-7] 'calendar)
(global-set-key [kp-8] 'list-bookmarks)
(setq bookmark-save-flag 1) ;; everytime bookmark is changed, automatically save it
(setq bookmark-save-flag t) ;; save bookmark when emacs quit


```

<2018-05-09 13:57>
在bookmark-lists界面下注意几个常用用法：

1. `d` ，进行标记to be deleted, 然后使用`x`，来执行deleted（先选中要删除，再进行真正的删除）
2. `l`  添加文件到bookmarks 或者 `c-x r m`(来添加当前文件到bookmark lists)
3. 

不常用用法： `e`添加当前item的annotation,`A`在另外一个窗口显示说明

注意，有可能第一次按下7和8没有反应，得emacs启动之后，就会有效果了

农历的效果。(按下S 可以查看cursor所在的日出日落时间)
![calendar][29]


### 21. 使用21世纪产品complte替换autocomplete

##### 函数名:


[company][32]

1. 增加company in the my-packages @ init.el
2. write code below in the editing.el

```
(add-hook 'after-init-hook 'global-company-mode)
```

3. comment out关于auto-complete的配置@editing.el
```
;; subsititude by compltee
;; init auto-complete
;;(require 'auto-complete-config)
;;(ac-config-default)
```

可以进一步阅读[company-mode官网][35]


### 22. 添加了evil-surround(但是得有evil，所以暂时搁置)


[evil-surround][31]

1. 增加evil-surround in the my-packages @init.el
2. add the setting code for evil-surround
```

(require 'evil-surround)
(global-evil-surround-mode 1)

```


### 23. 为了使用iy-go-to-char结合key-chord

##### 函数名:

1.iy-go-to-char
2. 宏名 key-chord-define-global


[iy-go-to-char][33]

[key-chord][34]


1. 增加iy-go-to-char and key-chord in the my-package @init.el
2. add the key-chord setting code @editing.el

```

(require 'key-chord)
(key-chord-mode 1)
;; Move to char similar to "f" in vim, f+g forward  d+f backward
(key-chord-define-global "ff" 'iy-go-to-char)
(key-chord-define-global "aa" 'iy-go-to-char-backward)

```

3. so 你可以快速的摁下ff(俩字母跳转)跳转到一个输入框让你输入一个char
或者 aa向后全局跳转(进入重复查找模式，反复摁下搜索字符，逐步向前或者
向后查找)

key-chord设置的是两个相同的key是最长0.2s延迟输入，若是两个不同的key则是
0.1s延迟输入,见[keychord.el][36]。

### 24. ace-jump-mode

Seen from [emacs-rocks-10][38]
#### 函数名

1. ace-jump-mode

[ace-jump-mode][30]

1. add the ace-jump-mode in the my-packags @init.el
2. add the setting code for the ace-jump-mode @navigation.el

```
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
```
3. when you input "C-c SPC" , the minibuffer will prompt you to input
the character you wana jump.

![ace][44]

### 25. emacs标记

有时候写着东西，你需要跳转到文内其他地方，查完之后，又想跳回来，vim比较简单(C-o)

emacs对应的先标记
`C-x SPC a`, a代表标记键，可以为a-z
然后调回来使用，
`C-x r j` : 表示跳转到某个文件
`C-x r s` : 表示复制当前信息到某个文件
 
 有些人也说可以用C-SPC，然后C-x c-x跳转即可(进一步可以参考[标题16][151])。
 
 
### 26. transpose character and words

Seen from [emacs-rocks-2 and 3][41]

```
C-t transpose two chars<2018-05-16 13:08>再次学习

M-t transpose two words

C-x C-t transpose lines

M-u make letters uppercase in word from cursor position to end

M-c simply make first letter in word uppercase

M-l opposite to M-u
```


### 27. Dired details

1. add dired-details+ and dired+ to mypackages @init.el

2. add the below code @ui.el

```
(require 'dired-details)
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)


;;Move files between split panes
(setq dired-dwim-target t)

```

3. when you `M-x dired`
you can see the clean info in the directory, then you can
use right parenthesis to get the detail info(user,priviliedge,dates etc) ,you can use left parenthesis to hide the details of file.

so

a. use m to mark the files, use u to unmark the files

b. use D to delete the files in prepare, and execute with x

c. when you finish m  , you can move(with command R) ,you can
   copy(with command C), you can delete(with command d)
 
d. use plus(+) to create an new directory.

e. Funny place. Emacs can simultaneously open two directory by
    open two buffers in the left-right zones, so you can use left
    zones as source directory, the right zones as target directory
    for copying and moving files.
    
![dired][43]



### 28. modify yassnipet and dired from magnars

`M-x package-install buster-snippet`

`M-x package-install angular-snippet`

`M-x package-install datomic-snippet`



1. copy all the snippets folder into your .emacs.d dir.
2. add require message @init.el(you can check it)

and also add the htmlize, highlight-escape-sequences,and
js2-mode package


###  29.html-mode 

#### 函数
1. zencoding-expand-line
add the `zencoding-mode` @setup-html-mode.el.

在html-mode中又增加了[zen-conding-mode][47],快捷的编辑html(C-j)


### 30. move-text

#### 函数
1. move-text-up
2. move-text-down


[move-text][48]

(move-text-default-bindings) add in the editing.el,


### 31. 我有一个困惑：how should I do with Org-mode

看了Sachac的[baby-steps-org-todo][49],我明白了relate(关系到底是什么),也就是todo大致应该group into project,
all the subtitle should be connected or related to the project, that's todo!

[Stein org-mode workflow][327]

```
* Project ABC
** TODO A task related to Project ABC(The first most important thing)
** TODO Another task related to ABC(The second most important thing)
** TODO Etc.(What about others?)
* Project XYZ
** TODO A task related to Project XYZpll(The first most important thing)
** TODO Another task related to XYZ(The second most important thing)
** TODO Etc.
* Tasks
** TODO Miscellaneous
** TODO tasks
** TODO go here
```

![baby-org-mode][50]

Hope ,when you see it, do work for you!



### 32. 快速注释

C-x C-; 单行注释

M-h  M-x comment-with-box 注释一个区域


### 33. projectile介绍

#### 函数

1. projectile-find-file  快捷键`C-c C-p f`  <2018-07-31 00:03>改成这种风格了([projectile7月升级][361]之后有所改变）


但是随着更新又发生了默认的改变([8月升级][362]),得添加`projectile-mode-map`

``` org

;;<2018-08-18 21:52>
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;Ivy-resume and other commands
```
你可以使用 M-x projectile-mode 进入projectile模式(默认进入)

有一个比较有趣的命令，`C-c p l` 在当前目录查找文件(类似在当前项目查找文件`C-c p f`) , 对应函数为`projectile-counsel-find-file-in-diretory`

还有一个有趣的命令`C-c p F` 表示在一直项目下查找文件,对应函数为`projectile-find-file-in-known-projects`



在vim中有一个类似的软件叫做[Ctrl-space][52],[projectile][51]会把git或者其他代码管理软件，亦或者你的lein，maven，budler等
相关的文件夹当作一个project，如果啥都没有创建一个.projectile,那么该文件夹也会被识别为project


基本查找项目文件内的file(C-c是保留的快捷键)


`C-c c-p f`

![projectile][55]

#### what is counsel-projectile

``` org
  Projectile has native support for using ivy as its completion system.
Counsel-projectile provides further ivy integration into projectile 
by taking advantage of ivy's support for selecting from a list of actions 
and applying an action without leaving the completion session.
Concretely, counsel-projectile defines replacements for existing projectile 
commands as well as new commands that have no projectile counterparts.
A minor mode is also provided that adds key bindings for all these commands on top of the projectile key bindings.

```

1. [ projectile ][51]是基本emacs包(实际上projectile will index all the files under the folder of your specified project,indexing mechanism)，他有很多拓展，包括[ counsel-projectile ][363], [ helm-projectile ][364], [ persp-projectile ][365],[ projectiel-rails ][366]
2. counsel-projectile是连接projectile和ivy的工具，相当于map过程，把projectile输出的结果，通过ivy封装，利用ivy的一个特性，list显示出来所有
选项，使得显示效果好看些.(原来ivy是一个图形化的list列表显示工具)


### 34. Web-mode介绍

[web-mode.el][53] is an emacs major mode for editing web templates aka HTML files embedding parts (CSS/JavaScript) and blocks (pre rendered by client/server side engines).

更详细的使用方法参考[Web-mode.org][54]


### 35. 自动弹出org-agenda窗口(5min idle)

在阅读[Sachac.org][57]的idle-time了解到在emacs闲置状态时候可以让其自动
打开org-agenda的命令，她也是参考了[Displaying your Org agenda after idle time][56], 进一步使用spacemacs-dark主题替换掉之前的的dracula-theme,参考editing.el的配置

![spacemacs][59]

### 36. tag标签增加

在emacs配置文件夹下的.orgConf增加了新的标签控制，觉得还是挺有用的，有时候可以在newgtd.org中c-c c-q添加一下
这样就能提醒你，同时也加入了project和context的思想(参考[todotxt.org][60]),project在标签中使用+打头的，而
context类似于签到地方，使用@字符打头的。

```
("紧急重要" . ?a)
("紧急不重要" . ?b)
("不紧急重要" . ?c)
("不紧急不重要" . ?d)
```

### 37. org-capture-template的修改


Capture is a facility for quickly adding to your org-files with minimal distruption to your [work flow][383].
It super
```
("t" "Todo" entry  (file+headline "~/.emacs.d/GTD/newgtd.org" "Tasks")
                    "* TODO [#B] %^{Task} %^g
                    :PROPERTIES:
                    :Effort: %^{effort|1:00|0:05|0:15|0:30|2:00|4:00}
                    :END:
                    Captured %<%Y-%m-%d %H:%M>
                    %?

                    %i
                    " )
```
1. todo模板增加了^g的控制，强制需要输入tag才让你键入org system中
2. 模板中的%？的作用表示当完成之后 cursor会出现在那里，并且可以开始输入
3. 增加了权限控制[#A] [#B] [#C] ,并且在随后的org-agenda-custom-command中增加了pa,pb,pc快速定义到满足某一权限的todo terms
4. 增加了Effort的属性控制， %^{}是一个listbox的选项，prompt you to input the values in the list.

部分org-agenda-custom-command的代码:

```
        ("p" . "Priorities")
        ("pa" "A items" tags-todo "+PRIORITY=\"A\"")
        ("pb" "B items" tags-todo "+PRIORITY=\"B\"")
        ("pc" "C items" tags-todo "+PRIORITY=\"C\"")

```

### 38. cljr-refactor实验

#### 函数

1. [cljr-thread-last-all][61] 使用-->进行重构，-->意思抽取最后一个参数放在第一行，然后倒数第二个第二行 依次排列
2. [cljr-thread-first-all][62] 使用->进行重构, -> 意思抽取最内层的第一个参数放在第一行 然后递归出来。
3. [cljr-unwind-all][63] -->和->的反向操作
4. [cljr-unwind][64]
5. [cljr-cycle-privacy][65]
6. [cljr-add-missing-libspec][66]
7. [cljr-promote-function][67] 从#(%)匿名函数的形式提高到(fn [k] (-> k ..))的形式,类似于org-mode的%^{}会提醒
    你输入对应的值，所以现在如果有几个%就会提醒你输入几次

```

(map square (filter even? [1 2  3 4]))
(->> [1 2  3 4]
     (filter even?)
     (map square))
(-> square
    (map (filter even? [1 2  3 4])))

(map str/join (map reverse (map (conj [:a :ab] :abc))))
;; cljr-unwind-all   pk   cljr-thread-last-all       pk cljr-thread-first-all
(->> :abc
     (conj [:a :ab])
     map
     (map reverse)
     (map str/join))
(map str/join (map reverse (map (conj [:a :ab] :abc))))

;; cljr-cycle-privacy
(defn- foo
  (println "hello"))


(map #(-> % (str "!") symbol) '[aaa bbb]) ;;光标定位到#()里头即可
(map (fn [k] (-> k (str "!") symbol)) '[aaa bbb])


(reduce #(assoc %1 %2 (name %2)) {} [:a :b :c])
(reduce (fn [k m] (assoc k m (name m))) {} [:a :b :c])

```


### 39. 重新思考init.el

你会使用`(add-to-list 'load-path Directory-name)`
来添加Directory-name的信息到Emacs interpreter的查找路径中，
这样你就可以load-file或者你可以使用(eval-after-load 'js2-mode '(require 'setup-js2-mode))来加载provide内容(注意你之所以能够require，是因为你做了两部分工作

1. `(add-to-list 'load-path "~/.emacs.d/customizations/magnars/")` 添加文件搜索路径
2. 你在setup-js2-mode.el最后一行添加了`(provide 'setup-js2-mode) `
   
经过1和2两个工作之后你才可以在init.el中执行，
`(eval-after-load 'js2-mode '(require 'setup-js2-mode)) `
 
 
Emacs is an programmable text and plain editor(Emacs lisp is a programmable program langauge), you can extend,tinker,tweak it with your imagenation. Some one said:"If you teach some one emacs command,he can hack one night,and if you teach someone how to create emacs commands
,he can hack one lifetime". Emacs is wonderful, fucking awesome, fucking flexible.


Go to understand what emacs thinks and touch the emacs interpreter, read 
the book 《[Writing Gnu Emacs Extension][68]》

**C-c 通常代表的是 applied 某种功能到文件中 **

### 40. emacs结合fortran(windows 和ubuntu开始有点不一样了)

使用[fortpy][71],但是安装它废了不少劲，首先得安装deferred
`M-x package-install deferred` 安了4遍才安装上

然后是结合python，所以得事先在python命令行安装
```
pip install virtualenv
pip install epc
pip install fortpy
```

安装fortpy python还提醒vcpython.exe(windows user 需要注意)
```
针对windows的/问题

stutils.errors.DistutilsError: Setup script exited with error: Microsoft Visual C++ 9.0 is required. Get it from http://aka.ms/vcpython27


原因是需要vcpython2.7来编译 fortpy套装的scipy-0.19.1.tar.gz，所以如果事先
安装scipy,可能不需要vcpython2.7. 这一步编译时间也得10min钟

Installing collected packages: numpy, scipy, pytz, cycler, pyparsing, functools32, matplotlib, tqdm, argparse, pycparser, cffi, pynacl, asn1crypto, idna, ipaddress, enum34, cryptography, bcrypt, pyasn1, paramiko, termcolor, fortpy

总共需要安装的python套件

又遇到这种问题
      raise NotFoundError('no lapack/blas resources found')
    numpy.distutils.system_info.NotFoundError: no lapack/blas resources found
缺少lapacka/blas

通过http://www.voidcn.com/article/p-cyvbbzty-bhh.html
python资源真是丰富
http://www.lfd.uci.edu/~gohlke/pythonlibs/#numpy

通过http://blog.csdn.net/inter_peng/article/details/53222562
指示，进行命令行安装whl文件(pip识别文件）

D:\迅雷下载>pip install "numpy-1.13.3+mkl-cp27-cp27m-win_amd64.whl"
Processing d:\????\numpy-1.13.3+mkl-cp27-cp27m-win_amd64.whl
Installing collected packages: numpy
  Found existing installation: numpy 1.13.3
    Uninstalling numpy-1.13.3:
      Successfully uninstalled numpy-1.13.3
Successfully installed numpy-1.13.3+mkl

D:\迅雷下载>pip install scipy-0.19.1-cp27-cp27m-win_amd64.whl
Processing d:\????\scipy-0.19.1-cp27-cp27m-win_amd64.whl
Requirement already satisfied: numpy>=1.8.2 in c:\python27\lib\site-packages (from scipy==0.19.1)
Installing collected packages: scipy
Successfully installed scipy-0.19.1



Fuck, it works!
  Running setup.py install for pycparser ... done
  Running setup.py install for termcolor ... done
Successfully installed argparse-1.4.0 asn1crypto-0.23.0 bcrypt-3.1.3 cffi-1.11.0 cryptography-2.0.3 cycler-0.10.0 enum34-1.1.6 fortpy-1.7.7 functools32-3.2.3.post2 idna-2.6 ipaddress-1.0.18 matplotlib-2.0.2 paramiko-2.3.1 pyasn1-0.3.6 pycparser-2.18 pynacl-1.1.2 pyparsing-2.2.0 pytz-2017.2 termcolor-1.1.0 tqdm-4.17.1


```
### 41 使用frotran-index-args

[fortran-index-args][69]

科研遗产fortran代码经常出现大量的变量，为了方便观看最好使用该工具，可以看一个小的[fortran-index-args gif][70]


为了使打开fortran90文件加载f90-mode,于是在fortran-editing.el增加如下代码

```
;;---------------f90--------------------
(setq auto-mode-alist
    (append '(("\\.f90\\'" . f90-mode)
             ("\\.f95\\'" . f90-mode))
     auto-mode-alist))
```

![f90-mode][72]

### 42. Ubuntu system quickly download leining

You need to have java in your system first.

1. download [leining-2.71.1-standalone.jar][165],and put it under the ~/.lein/self-installs/ directory(解决国内有时候网络原因无法下载该jar包).
2. download the [lein script][164] in the official network, chmod +x lein
3. lein repl, ok it runs


### 43. quick sort

seen from [jianshu][74]

```
(defn quick-sort [nums] 
  (if (< (count nums) 2) 
    nums 
    (concat 
      (quick-sort (filter #(< % (first nums)) nums)) 
      (filter #(= % (first nums)) nums) 
      (quick-sort (filter #(> % (first nums)) nums)))))


```

`C-c C-e` to see the sexp result,

![quicsort][75]

### 44. literal programming and gtd

1. [literal programming Howard Abrams][76]
2. [how-to-use-Org-Babal-for-R][77]
3. [uncle glassman][78]  
4. [How I use Emacs and Org-mode to implement GTD][14]  very important for using org-mode in emacs!
5. [Norang: org-mode Organize Your life in plain text][82]
6. [Remember Mode Tutorial][85] 早先使用remember mode,现在基本上替换为org capture即可
7. [Your Mind is for having ideas, not holding them---David Allen][83]  Use org-mode to hold it
8. [A Brief Introduction to Literate Analytics With org-Babel][258]
9. [Liiterate programming with org-more--Fregory J Stein][326]

a. Capture(collect what has your attention)
```
Use an in-tray, notepad, digital list, or voice recorder to capture everything that has your attention. 
Little, big, personal and professional—all your to-do’s, projects, things to handle or finish. 
```

如果没有切实的目标、合理的计划和明确的重点，再多的努力也只是蛮干，浪费时间不讨好。

b. Clarify(Process what it means)
```
Take everything that you capture and ask: Is it actionable? If no, then trash it, incubate it, 
or file it as reference. If yes, decide the very next action required. If it will take less than 
two minutes, do it now. If not, delegate it if you can; or put it on a list to do when you can. 
```
c. Organize(put it where it belongs)
```
Put action reminders on the right lists. For example, create lists for the appropriate categories
—calls to make, errands to run, emails to send, etc. 
```

形成你自己的视觉卡片,一个人学习能力究竟达到怎样的水平，试着制作一张视觉卡片就明了了
 
![vision card][271]

制作视觉卡片并不是浪费时间的过程【关键词的辐射作用】
以中点扩散，顺时针分块，以起点向四周发散，顺时针依次排开，这既是制作视觉卡片的基本原则，
也是阅读时的最佳顺序【调研发现这种方式符合人脑自然地运作方式，可以十分有效地帮助我们在
阅读的同时深度处理信息，为接下来的两个阶段打好基础】

绘制卡片技巧: 常用的生理感官【眼耳鼻舌生意】

一本书，一篇文章，一个拼图有其相同点，或者分章节组成，或者由一个一个小图片组成，
书有时候存在脉络不清楚，得细读围观线索，而拼图则是脉络清晰,可进行宏观把控。


d. Reflect(review frequently,weekly review, monthly review)
```
Look over your lists as often as necessary to trust your choices about what to do next. Do a weekly 
review to get clear, get current, and get creative. 
```
e. Engage(Simply do)(engine <2018-04-23 19:04>)
```
Use your system to take appropriate actions with confidence. 
```

CCORE[C-CORE]
Org---Interprete(evaluate)---Tag---Recite----apply-----

原来文学编程也是可以设置变量

```
#+begin_src sh :session *ssh goblin.howardism.org* :var dir="/opt"
   ls $dir
#+end_src
```


### 45. 更好的org-mode bullet

Frome [uncle glassman][78] , found the setting about the bullets [orgmode-wordprocessor][79],

add code below in the .orgConf.el

```
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
```


![bullet style][80]


<2018-05-02 05:15> 改进无法显示的字符,通过修改org-bullets.el

``` elisp

(defcustom org-bullets-bullet-list
  '(;;; Large
    "◎"
    "○"
    "✸"
    "✿"
    ;; ♥ ● ◇ ✚ ✜ ☯ ◆ ♠ ♣ ♦ ☢ ❀ ◆ ◖ ▶
    ;;; Small
    ;; ► • ★ ▸
    )
  "List of bullets used in Org headings.
It can contain any number of symbols, which will be repeated."
  :group 'org-bullets
  :type '(repeat (string :tag "Bullet character")))


```

要注意为了让org-bullet.el生效，必须删掉对应的org-bullet.elc[已编译的文件，emacs发现存在elc文件，则不会读取对应的el文件，所以必须先删掉它]

如果真的找不到，一定得去icon label查找[你需要的图标][235]放入emacs text中


### 46. more better font title bullet

```
(let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
                             ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
                             ((x-list-fonts "Verdana")         '(:font "Verdana"))
                             ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                             (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

  (custom-theme-set-faces 'user
                          `(org-level-8 ((t (,@headline ,@variable-tuple))))
                          `(org-level-7 ((t (,@headline ,@variable-tuple))))
                          `(org-level-6 ((t (,@headline ,@variable-tuple))))
                          `(org-level-5 ((t (,@headline ,@variable-tuple))))
                          `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
                          `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
                          `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
                          `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
                          `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil))))))
```


![new gtd style][81]

时间管理的最大意义并非让我们在同样的时间里学会更多的内容，而是帮助我们提高学习效率，
从而在改善学习效果的同时有更多的休闲时间，并且心安理得的享受这些休闲时间.

### 47. 常见verb(*****)

。

#### 任务（TASKS）

任何任务都应该用明确的动词来表征「Next Action」的行为，并记述该动词的目的和行为的目标。这样一来你不需要再次思考任务的形式，从而简单地执行。比如，与其写「周报告」不如以「总结这一周的来表述任务的内容更加能够容易理解该做什么。

我用以下的词汇来表征任务表：
```

处理，提问，回避，购买，变更，明确（澄清），收集，委托，从事，深思，创建，决定，延期，开发，废弃，
重做，下载，输入，整理（file)，跟踪，雇佣，改善，增 加，通知，查询，维持，测定，监测，订货，
描画，打电话，设置优先级，购入，质疑，减少，记忆，修理，回复，报告，调查研究，解决，回顾，
安排，卖，送，服务，详细设定，开始， 停止，建议，清扫，坐车，更新，升级，写。

构建，定义，执行列表(makefile)，做， 执行, 安排, 推送， 拉取, 观察, 仔细观察,感觉,拾取，拓展
工作，学习，使用，提高，查找，分类，阅读，练习，分解，深入，
见面，加载，调试，追踪
```

 Each task is written to begin with a "Next Action" Verb and an object or target of the verb. It is much easier to take action if you know what you need to do without reassessing the task. For example, "Weekly Report" is unclear whereas "Compile weekly call statistics" tells me what needs to be done.
 
Here is my list of action verbs:

```
Address, ask, avoid, buy, change, clarify, collect, commend confront, consider, create, decide, defer, develop, discard, 
do again, download, enter, file, follow up, hire, improve, increase, inform, inquire, maintain, measure, monitor, order, 
paint, phone, prioritize, purchase, question, reduce, remember, repair, reply, report, research, resolve, review, schedule, 
sell, send, service, specify, start, stop, suggest, tidy, train, update, upgrade, write. 
Build, Define, Make ， do, perform, arrange, push, pull， watch,perceive，sense，pick，extend
work， learn，use, improve, find, classify, read,practice,break into pieces(decompose),delve into
meet,load,debug,track
```


One task list: 
```
   Tasks:      TODO Write descrip of my GTD / orgmode                  :COMPUTER:
   Tasks:      TODO Study the Inkscape Tutorial Book                   :COMPUTER:
   Tasks:      TODO Write an article about org-mode vocabulary capture :COMPUTER:
   Projects:   TODO Write notes and lists of Japanese adjectives       :COMPUTER:
   Financial:  TODO Pay Mastercard                                     :COMPUTER:
   Projects:   TODO Tidy up my GTD web site .. directory on display    :COMPUTER:
   Tasks:      TODO Watch TOKYO STORY                                       :DVD:
   Projects:   TODO Daily Hiragana review on Anki                          :HOME:
   Projects:   TODO Daily Katakana review on Anki                          :HOME:
   Projects:   TODO Study - Beyond Words: A Guide to Drawing Out Ideas     :HOME:
   Projects:   TODO Read TALE OF THE GENJI                              :READING:
  
```


#### 工程项目

我使用这个分类来记录各个工程项目中的详细信息。一个工程项目对应一个以上的行动，并且它们通常都付有结束的日期。
在各个工程项目的目录中记述项目的内容，换句话说就是细化项目流程，在其下方用目录构造表示。
与任务的（Next Action）中说明的一样，这里我也用一些动词来表述项目：
    
    终结，决定，处理，调查，提交，扩大，组织，设计，完成，
    确保，研究，展开，更新，安装，改良，设定，缩小。


 This section is used to store details of each project I am working on. A project is a group of activities with a specific outcome that requires more than one action step and usually has a target date for completion.
Each project is stored as as heading with a subheading to contain a description of the project, and a work breakdown structure.
I use a set of Project Verbs in a similar manner to how I write Tasks (Next Actions):

    Finalize, resolve, handle, look into, submit, maximize, organize, design, complete,
    ensure, research, roll out, update, install, implement, set-up, minimize. 



### 48. 被忽略的细节：Tag具有继承性

Tag(org-tag-alist)是有继承性的，也就是说，假如一级标题的tag有work，则该级标题以下的所有子标题无论是否显式注明，都自动具有work的标签。例如：

```
: * Meeting with sb. :work:
 
: ** Summary with sb1. :boss:notes:
 
: *** TODO Prepare slides for him :action:
```

Summary with sb1的标签就是work, boss, notes，最后一项的标签就是work, boss, notes, action.


### 49. 打开evil-mode和关闭evil-mode

执行一次`M-x evil-mode` 表示打开,这样就可以使用vim的text object, 和跳转之类的命令了。

再执行一次`M-x evil-mode` 表示关闭

### 50. org-mode thinking(philosophy)

writing can be seen from your organization and simplication.

```
    Writing can be both art and communication; indeed, real communication
    happens only when writing is charged with artistic passion.
    For Nils, a key word is Composition. Nils once took a course in photography from a teacher
    who declared that:
    Composition = Organisation + Simpliﬁcation.
    "composition is the best way of seeing"
```


orgmode计时[<2018-04-23 20:20> 再次review],
 在todo.org中，移到一个条目上[一般是一个标题下]，按`Ctrl-c Ctrl-x Ctrl-i`即可对该条目开始计时，`Ctrl-c Ctrl-x Ctrl-o`停止当前计时。
 如果在Agenda中，移到条目按I(大写)即可对该条目开始计时，O(大写)即可停止计时。

<2018-05-02 05:57>
what is org-mode?

```
It’s an information organization platform. Its website says “Your life in plain text: 
Org mode is for 

1. keeping notes, 
2. maintaining TODO lists, 
3. planning projects, and 
4. authoring documents with a fast and effective plain-text system.”
```

通过`M-x org-todo-list` 显示所有agenda底下监控的todo标签

### 51. custome code block

when you need to memorize the source code in the .org file, one way you can use
`<s tab` , the other way you can refer to [wenshanren][88]

```
(defun org-insert-src-block (src-code-type)
  "Insert a `SRC-CODE-TYPE' type source code block in org-mode."
  (interactive
   (let ((src-code-types
          '("emacs-lisp" "python" "C" "sh" "java" "js" "clojure" "C++" "css"
            "calc" "asymptote" "dot" "gnuplot" "ledger" "lilypond" "mscgen"
            "octave" "oz" "plantuml" "R" "sass" "screen" "sql" "awk" "ditaa"
            "haskell" "latex" "lisp" "matlab" "ocaml" "org" "perl" "ruby"
            "scheme" "sqlite")))
     (list (ido-completing-read "Source code type: " src-code-types))))
  (progn
    (newline-and-indent)
    (insert (format "#+BEGIN_SRC %s\n" src-code-type))
    (newline-and-indent)
    (insert "#+END_SRC\n")
    (previous-line 2)
    (org-edit-src-code)))
```

通过`M-x org-insert-src-block`,然后输入代码类型,也不错。

除了emacs-lisp不需要设置org-babel-load-language外，其他都得设置loading language true. 

1. [org-babel语言配置][90]
2. [org-babel介绍][89]
3. [org-babel支持的语言][91]
4. [安装graphviz][92]
     先安装，并添加到path中，然后执行代码块， 所有的配置可以参考.orgConf.el(又重新学习了一遍)。
     
 ```
 
 
 #+BEGIN_SRC emacs-lisp
   (+ 1 2 3 4)
 #+END_SRC

 #+RESULTS:
 : 10


;you need to set the language for running the python source code 

 #+BEGIN_SRC python
   a=1+1
   print a
 #+END_SRC

 #+RESULTS:
 : None


;; you need to set the language for running the perl source code
 #+BEGIN_SRC perl
   my $hello="df";
   print "$hello \n perl \n";
 #+END_SRC

 #+RESULTS:
 : 1


;; You need to set the language for running the c++ source code
 #+BEGIN_SRC C++
     int a=1;
     int b=1;
     printf("%d\n", a+b);
 #+END_SRC

 #+RESULTS:
 
 
;; <2018-05-03 03:22>  再次学习
#+BEGIN_SRC dot :file some-illustration.png
  digraph {
    a -> b;
    b -> c:
    c -> a;
  }
#+END_SRC


 #+BEGIN_SRC dot :file a.png
       digraph colla_schema {  
           UserA -> UserB[label = "Liked", color = green];  
           UserB -> UserA[label = "Liked_By", color = red];  
       }  
 #+END_SRC

 #+RESULTS:
 [[file:a.png]]
 ```

[额外的控制][242]

``` elisp
Good Configuration
To syntax highlight your code, set the following in your .emacs init file:

(setq org-confirm-babel-evaluate nil
      org-src-fontify-natively t
      org-src-tab-acts-natively t)
The last variable removes the annoying “Do you want to execute” your code when you type: C-c C-c
```


关于[emacs-calculator][243]:

```

   #+BEGIN_SRC calc :var a=2 b=9 c=64 x=5
     ((a+b)^3 +sqrt(c))/(2x+1)
   #+END_SRC

   #+RESULTS:
   : 121.727272727


```

使用时候必须，先`M-x load-library`,然后输如`ob-calc`就可以使用`C-c C-c` 了

 在每一个代码块执行`C-c C-c`即可看到结果（在windows配置完path之后，得重启系统,有些命令才有效)。
 很有意思的文学编程。( dame it, flyspell mode(flyspell mode 1) in the .orgConf.el)

<hr/> 

Code Evaluation?

``` org
| 属性       | 说明                                                  |
|------------|-------------------------------------------------------|
| 1. dir     | specify directory the code should run … Tramp?        |
| 2. session | re-use interpreter between code blocks                |
| 3. file    | write results to the file system                      |
| 4. eval    | limit evaluation of specific code blocks              |
| 5. cache   | cache eval results to avoid re-evaluation of blocks   |
| 6. var     | setting variables for a block (ignore with no-expand) |
|            |                                                       |

```
Exporting?

``` org
|         |                                             |
| results | either output or value and the formatting   |
| exports | how the code and results should be exported |
|         |                                             |

```

Special Output and Formatting?

``` org
| padline |                                       |
| post    | post processing of code block results |
| wrap    |                                       |
| Misc    | hlines, colnames, rownames            |
|         |                                       |
 
 ```

```
 C-c s i   创建一个代码块
 C-c s e   编辑代码块
 
 当时用1. 2. 时候 ，使用Esc退出，然后使用o进行当前item的插入新行操作[有用的操作]

 C-s-enter 表示插入大标题。<2018-04-27 00:14>
 M-enter 表示继续插入item标题号。
 
 C-c ,  在标题上面敲入该快捷键，可以插入权限控制标记
 ```
 
 进一步关于[org-mode权限控制][238]

另外关于org-mode的[property-syntax][239]也可以进行查看，快捷键是`C-c C-x p` to set property[<2018-05-03 00:55> PROPERTIES] for org-mode files.

观察[org-mind-map][240]写法发现，一个标题对应一个属性列表，相当于一个标题是一个对象。

### 53. 常用的clojure-snippet


[howardabrams clojure snippet][93]

[magnars clojure snippet][94]


### 54. org-autolist

[autolist][95]好处是可以在编辑列表项时候，前进(ret)回退的时候(backspace) 增加或者去掉整个当前的list项，详细看官方文档。

### 55. failed enable flyspell mode in window10

1. 首先安装Aspell
[Install aspell][96]
2. 然后安装[dictionary][100] ,安装完aspell之后，然后选择enlish version即可
, 在aspell目录下会产生dict文件夹.在customizations文件夹rar一个windows安装完english dictionary的aspell.rar文件，作为windows版本的备份，
linux版本需要额外配置一下。(另外如果不配置也不会另org-agenda崩溃，只是会提醒而已)

其他相关链接,

[solution with aspell][97]
[Effective spell check in Emacs][98]
[What's the best spell check set up in emacs][99]

```
(custom-set-variables
    '(ispell-dictionary "british")
    '(ispell-program-name "C:\\Program Files (x86)\\Aspell\\bin\\aspell.exe"))
```

If Aspell can not determine the language from the LC_MESSAGES locale than it will default to ``en_US''


### 56. 如何把journal.org分成每天日志的形式

[journal-org][101] : 类似于vimwiki的形式，每一个dairy都可以使用当天的hhmmdd.wiki创建，然后diary汇总。
现在也是创建一个journal文件夹，然后创建每天的journal。

```
(setq org-capture-template
    ...
       ("j" "Journal Note"
         ;entry (file+olp+datetree (find-file (get-journal-file-today)))
         entry (function get-journal-file-today)
         "* Event: %?\n\n  %i\n\n  From: %a"
         :empty-lines 1 )
    ...
)

;;; some other function

(defvar org-journal-dir "~/.emacs.d/GTD/orgBoss/Journal/")

;;https://github.com/howardabrams/dot-files/blob/master/emacs-org.org#journaling
;;These files do not have a .org extension, but we’re talking about Emacs, so I use this code to have org-mode be the default mode for filenames consisting of nothing but numbers: 

(defun get-journal-file-today ()
  "Return filename for today's journal entry."
  (let ((daily-name (format-time-string "%Y%m%d")))
    (format "\"%S\"" (expand-file-name (concat org-journal-dir daily-name)))
    ;(concat org-journal-dir daily-name)
    ))

(defun journal-file-today ()
  "Create and load a journal file based on today's date."
  (interactive)
  (find-file (get-journal-file-today)))


;add to orgmode
(add-to-list 'auto-mode-alist '(".*/[0-9]*$" . org-mode))

;; snippet
(defun journal-file-insert ()
  "Insert's the journal heading based on the file's name."
  (interactive)
  (when (string-match "\\(20[0-9][0-9]\\)\\([0-9][0-9]\\)\\([0-9][0-9]\\)"
                      (buffer-name))
    (let ((year  (string-to-number (match-string 1 (buffer-name))))
          (month (string-to-number (match-string 2 (buffer-name))))
          (day   (string-to-number (match-string 3 (buffer-name))))
          (datim nil))
      (setq datim (encode-time 0 0 0 day month year))
      (insert (format-time-string
                 "#+TITLE: Journal Entry- %Y-%b-%d (%A)\n\n" datim)))))

(setq auto-insert t)
(setq auto-insert-query t)
(add-hook 'find-file-hook 'auto-insert)

;(add-to-list 'auto-insert-alist '(".*/[0-9]*$" . journal-file-insert))
;(define-auto-insert '(".*/[0-9]*$" . journal-file-insert))
(defvar auto-insert-alist '())
(setq auto-insert-alist
      (append '(
            (".*/[0-9]*$" . journal-file-insert)
           
            )
           auto-insert-alist))


(global-set-key (kbd "C-c f j") 'journal-file-today)


(defun get-journal-file-yesterday ()
  "Return filename for yesterday's journal entry."
  (let* ((yesterday (time-subtract (current-time) (days-to-time 1)))
         (daily-name (format-time-string "%Y%m%d" yesterday)))
    (expand-file-name (concat org-journal-dir daily-name))))

(defun journal-file-yesterday ()
  "Creates and load a file based on yesterday's date."
  (interactive)
  (find-file (get-journal-file-yesterday)))

(global-set-key (kbd "C-c f y") 'journal-file-yesterday)
;;https://github.com/howardabrams/dot-files/blob/master/emacs-org.org#displaying-last-years-journal-entry

(defun journal-last-year-file ()
  "Returns the string corresponding to the journal entry that
happened 'last year' at this same time (meaning on the same day
of the week)."
(let* ((last-year-seconds (- (float-time) (* 365 24 60 60)))
       (last-year (seconds-to-time last-year-seconds))
       (last-year-dow (nth 6 (decode-time last-year)))
       (this-year-dow (nth 6 (decode-time)))
       (difference (if (> this-year-dow last-year-dow)
                       (- this-year-dow last-year-dow)
                     (- last-year-dow this-year-dow)))
       (target-date-seconds (+ last-year-seconds (* difference 24 60 60)))
       (target-date (seconds-to-time target-date-seconds)))
  (format-time-string "%Y%m%d" target-date)))

(defun journal-last-year ()
  "Loads last year's journal entry, which is not necessary the
same day of the month, but will be the same day of the week."
  (interactive)
  (let ((journal-file (concat org-journal-dir (journal-last-year-file))))
    (find-file journal-file)))

  (global-set-key (kbd "C-c f L") 'journal-last-year)




```

file+dateree have been deprecated, changed to date+olp+dateree
see [capture][102]


但是`C-c c j`还存在bug，因为entry调用函数失败！！


[journal-file-insert][103]更新，

```
(defun journal-file-insert ()
  "Insert's the journal heading based on the file's name."
  (interactive)
  (let* ((year  (string-to-number (substring (buffer-name) 0 4)))
         (month (string-to-number (substring (buffer-name) 4 6)))
         (day   (string-to-number (substring (buffer-name) 6 8)))
         (datim (encode-time 0 0 0 day month year)))

      (insert (format-time-string org-journal-date-format datim))
      (insert "\n\n  $0\n") ; Start with a blank separating line

      ;; Note: The `insert-file-contents' leaves the cursor at the
      ;; beginning, so the easiest approach is to insert these files
      ;; in reverse order:

      ;; If the journal entry I'm creating matches today's date:
      (when (equal (file-name-base (buffer-file-name))
                   (format-time-string "%Y%m%d"))
        (insert-file-contents "journal-dailies-end.org")

        ;; Insert dailies that only happen once a week:
        (let ((weekday-template (downcase
                                 (format-time-string "journal-%a.org"))))
          (when (file-exists-p weekday-template)
            (insert-file-contents weekday-template)))
        (insert-file-contents "journal-dailies.org")
        (insert "$0")

        (let ((contents (buffer-string)))
          (delete-region (point-min) (point-max))
          (yas-expand-snippet contents (point-min) (point-max))))))

(define-auto-insert "/[0-9]\\{8\\}$" [journal-file-insert])

```

配合[org-journal][104],更好的记录journal,
默认需要配置org-journal-dir，`(setq org-journal-dir "~/.emacs.d/GTD/orgBoss/Journal/`
然后就可以使用常用的命令，甚至在calendar也可以配合使用

```

Bindings available in org-journal-mode:

    C-c C-f - go to the next journal file.
    C-c C-b - go to the previous journal file.
    C-c C-j - insert a new entry into the current journal file (creates the file if not present).
    C-c C-s - search the journal for a string.

All journal entries are registered in the Emacs Calendar. To see available journal entries do M-x calendar. Bindings available in the calendar-mode:

    j - view an entry in a new buffer.(org-journal-new-entry)
    C-j - view an entry but do not switch to it.
    i j - add a new entry into the day’s file (creates the file if not present).(org-journal-new-date-entry)
    f w - search in all entries of the current week.(org-journal-search-calendar-week 可以快速查找一周内的日记内容) 
    f m - search in all entries of the current month.(org-jounal-search-calendar-month 月查记录)
    f y - search in all entries of the current year.(org-journal-search-calendar-year 年查记录)
    f f - search in all entries of all time.
    [ - go to previous day with journal entries.
    ] - go to next day with journal entries.
    
    <2018-04-26 00:29> .好表示回到今日 
    
    g d 到指定年月日
    g D 到某年的第几天
    g w 到某年的第几周
    o 到某年某月居中
    
    
    C-a 到周的开始
    C-e 到周的结束
    M-a 到月的开始
    M-e 到月的结束
    
    C-f 前移一天
    C-b 后羿一天
    C-n 前移一周
    C-p 后移一周
    M-} 前移一月
    M-{ 后移一月
    C-x -] 前移一年
    C-x -[ 后移一年
    
    M-< 到年的开始
    M-> 到年的结束
    
    
    很有意思的一个命令：x  在日历窗口标出命令、
          M-x holidays 在另一个窗口列出近三个月节日   a列出当前日历近三个月所有几日

```

有点遗憾的地方，没有让org-capture-templates中的entry执行函数，还不清楚为什么。

![oo][105]

### 57. org as an presentations

[howardabrams][106] alternated between the browser-based presentation tool, [reveal.js][108] and staying in Emacs with [org-tree-slide][107].

#### In emacs, org-tree-slide(边写org，边做幻灯片)

##### 函数

1. org-tree-slide-move-next-tree (C->)
2. org-tree-slide-move-previous-tree (C-<)
3. org-tree-slide-content (C-x s c) 目录
4. org-tree-slide-skip-done-toggle 切换slide模式
5. org-tree-slide-mode 进入slide mode

I. first install `M-x package-install org-tree-slide`

II. 在ui.el添加如下配置
```
(when (require 'org-tree-slide nil t)
  (global-set-key (kbd "<f7>") 'org-tree-slide-mode)
  (global-set-key (kbd "S-<f7>") 'org-tree-slide-skip-done-toggle)
  (define-key org-tree-slide-mode-map (kbd "<f8>")
    'org-tree-slide-move-previous-tree)
  (define-key org-tree-slide-mode-map (kbd "<f9>")
    'org-tree-slide-move-next-tree)
  (define-key org-tree-slide-mode-map (kbd "S-<f9>")
    'org-tree-slide-content)
  (setq org-tree-slide-skip-outline-level 4)
  (org-tree-slide-narrowing-control-profile)
  (setq org-tree-slide-skip-done nil)))
```

F7表示进入slide模式，S-F7退出slide模式
F8前一页slide（前一个标题)
F9后一页slide(后一个标题)


#### Outside emacs, ox-reveal

1. first install [ox-reveal][109] `M-x package-install ox-reveal`

2. 第一次使用一定得load-library（不行就多试几次)
` M-x load-library ox-reveal
`

3. C-c c-e R R （中文乱码）
和C-c C-e h h用的不是同一个函数。

于是修改所有的org文件从ANSI的utf-8

特别注意,添加语言环境到init.el,这样所有新文件就会是utf-8编码格式
```
(set-language-environment "utf-8")

```
设置完，导出reveal.js的html才不会乱码！！

在.orgConf.el中的设置

```
;;ox-reveal outside emacs slide(inside emacs use org-tree-slide)
(require 'ox-reveal)
;(setq org-reveal-root "file:///~/.emacs.d/GTD/reveal.js")
;(setq org-reveal-root "~/.emacs.d/GTD/reveal.js/")
(setq org-reveal-root "file:///k:/reveal.js")
(setq org-reveal-postamble "Ye Zhaoliang")
```

注意一定得在磁盘根目录下的reveal.js文件夹下

<2018-05-02 02:36>  再次学习怎么使用[emacs+reveal.js做演讲][234]

``` org
#+ATTR_REVEAL: :frag (grow shrink roll-in fade-out none)
    * I will grow.
   * I will shrink.
   * I rolled in.
   * I will fade out.
   * I don't fragment.

```

1. grow
2. shrink
3. roll-in
4. fade-out
5. highlight-red
6. highlight-green
7. highlight-blue
8. appear


关于使用情况进一步参考 [how-create-slides-emacs-org-mode-and-revealjs][234]

一个完整的例子

``` org

#+OPTIONS: num:nil toc:nil
#+REVEAL_TRANS: Slide 
#+REVEAL_THEME: Black
#+Title: Slides by ox-reveal and reveal.js
#+Author: Ye Zhaoliang
#+Email: zhaoturkkey@163.com 


#+ATTR_REVEAL: :frag (grow shrink roll-in fade-out none) 

* I will grow.
* I will shrink.
* I rolled in.
* I will fade out.
* I don't fragment.



#+ATTR_REVEAL: :frag (appear)
* I appear.
* I appear.
* I appear.

** Advance

#+BEGIN_NOTES
My notes
#+END_NOTES


很有意思的


#+BEGIN_SRC org
  ,#+BEGIN_NOTES

  演讲者模式
  使用s，进入演讲者模式，类似ppt

  ,#+END_NOTES
#+END_SRC

In interview with Magnar Sveen, he gives some good advice in learning Emacs:

1. Learn Emacs on its own. Don't try to "learn Emacs and Clojure" for instance. I would suggest learn new tools before you have to use it.
2. Grab a friend who already knows it. I would suggest that if you don't have that, at least learn it with a friend who is also learning it.
3. Everyone has their own way of learning something new, so whether you make flash cards, graphical notes, or whatever, use what you know works for you.
Unless Sacha Chua got you first, let me know if I can help.

* image
:PROPERTIES:
:reveal_background: ./spacemacs.jpg
:reveal_background_size: 800px
:reveal_background_trans: slide
:END:
* mathJax

${n! \over k!(n-k)!} = {n \choose k}$


```

很好看的结果

![math][236]

``` org
#+REVEAL_TRANS: None/Fade/Slide/Convex/Concave/Zoom
#+REVEAL_THEME: Black/White/League/Sky/Beige/Simple/Serif/Blood/Night/Moon/Solarized
```


<2018-05-03 23:28> 再次补充

#### 插入图片

直接使用双中括号即可，写入文件相对路径，ok！ 并且完美的支持，比如graphviz代码块生成的结果图片【无缝连接】

详细可以观看[create cool slide with reveal.js inside emacs org-mode][248]

#### 特别有趣的几个item控制或者超链接控制(伟大的ATTR_REVEAL)

```

[[http://www.google.co.uk][hyperlink-text]]

#+ATTR_REVEAL: :frag roll-in
  - bulletpoint
翻转链接的3D效果特别棒！！！

  
  全部显示为蓝色
#+ATTR_REVEAL: :frag highlight-blue
   * Create
   * Fragment
   * At Ease
   
   
  加了()逐个显示为蓝色{这个必须学会！！！}, 在这种情况得先选择一个单词，然后摁下S(大写的S)，输入左圆括号，就可以了
#+ATTR_REVEAL: :frag (highlight-blue)
    * I appear.
    * I appear.
    * I appear.

** Advance
   
#+CAPTION: The Org text source.
#+BEGIN_SRC org
#+ATTR_REVEAL: :frag
   * Create
   * Fragment
   * At Ease
#+END_SRC


```

#### 伟大的ESC键


<2018-05-04 01:24>   通过该键可以看到slide的全局布置

#### 有趣的split属性(强大的#+REVEAL)

reveal.js是通过split属性和标题进行划分一张幻灯片的，一般是header[1-6]每个header单独一张幻灯片，如果在header还想要
单独划分一页ppt，那么split把，split属性下面的都是新的幻灯片，直到新的split或者header[N]

快捷输入 `rsp tab` 即可

``` org
#+REVEAL: split
Evaluates all the code in the opened file

[[./images/lighttable-connect-evaluated-code.png]]


```

#### 定制css样式(伟大的CSS)

比如有一个样式叫做jr0cket.css，对应的使用是在org文件开头的 `#+REVEAL_THEME: jr0cket`

那么你得在` K:\reveal.js\css\theme` reveal.js的文件夹底下把该css放入其中才可以！

好看的ppt样式！

``` org
#+REVEAL_TRANS: linear
#+REVEAL_THEME: jr0cket

```

linear的效果是滑动切换！很明显， slide的方式切换不明显！！

[jr0cket.css的样式][24]  !!!!


#### bash细节

有时候为了对代码营造绿色的效果一般使用

``` org

#+begin_src bash

code....

#+end_src
```

#### 背景图片


有时候你需要在背景加上图标，比如华北电力大学，比如git图标、clojure图标等，这时候就需要添加背景图片的了

``` org
 :PROPERTIES:
    :reveal_background: ./images/clojure-slide-background.png
    :reveal_background_trans: slide
 :END:

```

### 58. Good job for clojure and lisp

Here is the good job from [Malabarba][112] who write the two completion feature for clojure and lisp;

1. elisp names [sotlisp][110]

   [elisp缩写词][113]
   
2. clojure names [sotclojure][111]

   [clojure缩写词][114]
   

使用方式得激活`M-x speed-of-thought-mode`
或者在editing.el中添加`(speed-of-thought-mode t)`即可。

clojure的定义函数，得在开启REPL模式下，才可以使用`C-c f`来调用`sotclojure-find-or-define-function`

`C-c f`是一个好命令，可以查看函数定义或者新建函数<2018-05-16 12:47> <2018-05-23 14:24>

`M-return`调用`sotlisp-newline-and-parentheses`

### 59. 自定义了插入一行

```

(defun my/insert-line-before (times)
  "Insert a  newline(s) above the line containing the cursor."
  (interactive "p")
  (save-excursion 
    (move-beginning-of-line 1)
    (newline times))
  )

(global-set-key (kbd "C-c i") 'my/insert-line-before)

```

函数说明: 
1. save-excursion保存当前位置
2. newline移动多少行(C-1 C-c i表示一行 C-6 C-c i表示6行，1和6由times接受.


目的： 可以使用C-c i在当前行插入一行，以示划分，一来留白，二来更清晰

### 60. 使用scope-capture

此topic和emacs配置无关， 和clojure项目有关。


github repo: [Scope-capture][116]


当你使用`lein new app app-name` 创建一个clojure项目，可以在
project.clj添加`M-x cljr-add-missing-lib`,添加scope-capture 

```
:dependencies [[org.clojure/clojure "1.8.0"]
                 [vvvvalvalval/scope-capture "0.1.0"]
                 [vvvvalvalval/scope-capture-nrepl "0.2.0"]]
```

在对应的clojure中使用
```
(ns first-example.core
  (:require [clojure.string :as str]
            sc.api))
```
具体使用，

```
(def distance
  (let [earth-radius 6.371e6
        radians-per-degree (/ Math/PI 180.0)]
    (fn [p1 p2]
      (let [[lat1 lng1] p1
            [lat2 lng2] p1
            phi1 (* lat1 radians-per-degree)
            lambda1 (* lng1 radians-per-degree)
            phi2 (* lat2 radians-per-degree)
            lambda2 (* lng2 radians-per-degree)]
        (sc.api/spy (* 2 earth-radius
                       (Math/asin 
                        (Math/sqrt
                         (+  
                          (haversine (- phi2 phi1))
                          (* 
                           (Math/cos phi1)
                           (Math/cos phi2)
                           (haversine (- lambda2 lambda1)))
                          )))))
        ))))

(def Paris [48.8566 2.3522])
(def New-York [40.7134 -74.0055])
(def Athens [37.9838 23.7275])

(distance Paris New-York)
(distance Paris Athens)
(distance New-York Athens)

(sc.api/ep-info 1)

(sc.api/defsc 1)

```


1. sc.api/spy 监视函数，插入code中,并结合(sc.api/defsc 1)就可以使用C-x C-e，进行逐行debug模式(监测段代码对应行进行evaluate)。

2. sc.api/ep-info 显示相关local name信息
3. sc.api/defsc   集合spy进行使用

其他参考[Tutorial][115]



### 61. customize the face for org top topic


Customize the face @.orgConf.el
```


(defface hi-purple-b '((t (:foreground "#9F5F9F"))) t)
;;; let header become better                                                                                     ;; ;;
                         
let* ((variable-tuple (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))                       ;; ;;
                             ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))                         ;; ;;
                             ((x-list-fonts "Verdana")         '(:font "Verdana"))                               ;; ;;
                             ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))                          ;; ;;
                             (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))           ;; ;;
      ; (base-font-color     (face-foreground 'default nil 'default))
       (base-font-color2    (face-foreground 'hi-purple-b nil 'default))
       (base-font-color     (face-foreground 'default nil 'default))                                             ;; ;;
       (headline           `(:inherit default :weight bold :foreground ,base-font-color))
       (headline2           `(:inherit default :weight bold :foreground ,base-font-color2))
)                       ;; ;;
       
                                                                                                                 ;; ;;
  (custom-theme-set-faces 'user                                                                                  ;; ;;
                          `(org-level-8 ((t (,@headline ,@variable-tuple))))                                     ;; ;;
                          `(org-level-7 ((t (,@headline ,@variable-tuple))))                                     ;; ;;
                          `(org-level-6 ((t (,@headline ,@variable-tuple))))                                     ;; ;;
                          `(org-level-5 ((t (,@headline ,@variable-tuple))))                                     ;; ;;
                          `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))                         ;; ;;
                          `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))                        ;; ;;
                          `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))                         ;; ;;
                          `(org-level-1 ((t (,@headline2 ,@variable-tuple :height 1.75))))    ;;here                     ;; ;;
                          `(org-document-title ((t (,@headline ,@variable-tuple :height 1.5 :underline nil)))))
```

Headline1 become purple now.

![headline1][117]


### 62. add journal additional files for generate day-jounal

see the journal folder @ `~/.emacs.d/GTD/orgBoss/`


### 63. Now I am listening music with emms in Windows10

1. [emms][118] 安装： `M-x package-install emms`

emms会去调用mplayer播放音乐和电影，所以得把mplayer下载，然后添加到path目录下，
这样emms.el就回去调用该播放器。

2. 离开emacs, [mplayer][119]下载，我把其放在E:/mpalyer底下（可以参看[mplayer官网][120]
```
 E:\MPlayer 的目录

2016/12/04  10:33    <DIR>          .
2016/12/04  10:33    <DIR>          ..
2016/12/04  10:33    <DIR>          fonts
2016/12/04  10:33            18,437 LICENSE.txt
2016/12/04  10:33        29,576,704 mencoder.exe
2016/12/04  10:33    <DIR>          mplayer
2016/12/04  10:33        31,128,064 mplayer.exe
2016/12/04  10:33           633,017 MPlayer.html
2016/12/04  10:33           534,832 MPlayer.man.html
2013/02/18  13:28             4,306 README.win32.txt
               6 个文件     61,895,360 字节
               4 个目录 50,590,359,552 可用字节
```
3. 添加E:/mplayer路径到path目录下

4. 回到emacs,在customizations文件夹下创建setup-emms.el,添加如下内容

以下配置来自[Chen Tao][122]
```
;; =============================================================================

;; emms mode settings ===================================================
;;   ___ _ __ ___  _ __ ___  ___
;;  / _ \ '_ ` _ \| '_ ` _ \/ __|
;; |  __/ | | | | | | | | | \__ \
;;  \___|_| |_| |_|_| |_| |_|___/
;;
(require 'emms-setup)
(emms-all)
(require 'emms-i18n)
(require 'emms-history)

;; (emms-default-players)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (setq emms-player-list       ;;
;;       '(emms-player-mplayer  ;;
;;         emms-player-mpg321   ;;
;;         emms-player-ogg123)) ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; use mplayer , that's enough!
(setq emms-player-list '(emms-player-mplayer) emms-player-mplayer-command-name "mplayer" emms-player-mplayer-parameters '("-slave"))

(setq emms-playlist-buffer-name "*Music*")

(add-hook 'emms-player-started-hook 'emms-show)
(setq emms-show-format "Now Playing: %s")
(setq emms-source-file-default-directory "H:/Classic/") ;;depend on yourself!! Change your music or movie directory

;; emms-playlist mode keys map
(global-set-key (kbd "C-c m s") 'emms-stop)
(global-set-key (kbd "C-c m P") 'emms-pause)
(global-set-key (kbd "C-c m n") 'emms-next)
(global-set-key (kbd "C-c m p") 'emms-previous)
(global-set-key (kbd "C-c m f") 'emms-show)
(global-set-key (kbd "C-c m >") 'emms-seek-forward)
(global-set-key (kbd "C-c m <") 'emms-seek-backward)

(global-set-key (kbd "C-c m S") 'emms-start)
(global-set-key (kbd "C-c m g") 'emms-playlist-mode-go)
(global-set-key (kbd "C-c m d") 'emms-play-directory-tree)
(global-set-key (kbd "C-c m h") 'emms-shuffle)
(global-set-key (kbd "C-c m e") 'emms-play-file)
(global-set-key (kbd "C-c m l") 'emms-play-playlist)
(global-set-key (kbd "C-c m r") 'emms-toggle-repeat-track)
(global-set-key (kbd "C-c m R") 'emms-toggle-repeat-playlist)

(add-hook 'emms-playlist-mode-hook
          (lambda ()
(toggle-truncate-lines 1)))

```

使用mplayer即可，解决所有emacs的music  and movie(注意播放电影的时候，实际上已经不在emacs界面下，
使用q退出mplayer,使用上下左右方向键进行快进等)播放问题。

自己定制你的音乐文件夹`emms-source-file-default-directory`!

5. 使用感受(m是music和movie的缩写）

- 常用函数
  + C-c m d(emms-play-directory-tree) 打开一个播放文件夹
  + C-c m g(emms-playlist-mode-go)  打开播放列表
  + RET 在播放列表下按下enter键表示播放
  ------------------------------------------------------以上三个命令够了
  + C-c m n(emms-next) 下一首
  + C-c m p(emms-previous) 上一首
  + C-c m P (emms-Pause)暂停
  + C-c m s (emms-stop) 停止
  + C-c m S (emms-start) 开始

首先打开一个音乐文件夹(不喜欢一个文件打开 `M-x emms-play-file(c-c m e) `,
喜欢使用`M-x emms-play-directory-tree(C-c m d)`；

![musiclist][123]

然后打开播放列表(使用`M-x emms或者M-x emms-playlist-mode-go(C-c m g)`)

有时候要播放下一首，就使用(`M-x emms-next(c-c m n)` 类似前一首`M-x emms-previous(C-c m p`)


[网友][121]，提供一个播放多个电影文件的方法

```
通過 Dired 打開電影目錄，比如其中有一個文件夾 辛德勒名單 ，裏面有4 個媒體文件：
辛德勒名單CD1.avi、辛德勒名單CD2.avi、辛德勒名單CD3.avi、辛德勒名單CD4.avi。我只需要將光標停在 辛德勒名單 文件夾上，
按 C-c e d ，調用 emms-play-dired 函數，則會自動建立播放列表，mplayer 按順序播放這4個文件。

比如有一個電視劇的文件夾 手機 ，裏面共有 36 集，我今天想看 10-12集，用 Dired 進入 手機 文件夾，用 m 在 10-12 集上做標記，
然後按 C-c e d ，mplayer 就會順次播放 10-12集。
```

### 64. 增强dired

从现在开始我[使用use-package][128]安装新的pacakge

github:[use-package][129]

[Spotlight: use-package, a declarative configuration tool][130]
```
It’s a declarative way of expressing package configuration in Emacs but without the tears. It’s written by the inimitable John Wiegley, the new GNU Emacs lead maintainer and author of many, many cool tools like a commandline ledger, Emacs’s Eshell, and much more.
```

安装dired-narrow,参考[此链接][124]
a. 问题: 出现dired-mode-map symbol无法解析的问题是因为没有`required 'dired`
b. 出现步骤：之前放置dired配置代码在ui.el，其实应该防止setup-dired.el当中
```
;;narrow dired to match filter
(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))
```

这样配置完就可以在`M-x dired(C-x d)`中使用/表示filter了

真的有[增强Dired][125]


[dired-range][126] is bookmark for dired,
These bookmarks are not persistent. If you want persistent bookmarks use the bookmarks provided by emacs, see (info "(emacs) Bookmarks").


[Copy and paste files with dired-ranger][127]
```
(use-package dired-ranger
  :ensure t
  :bind (:map dired-mode-map
              ("W" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("Y" . dired-ranger-paste)))
```


This also sets up some useful keybindings. Now in a dired buffer, 
you can mark multiple files and then hit W to copy them (really they are 
added to a copy ring). You could then optionally go to another directory 
and mark more files and hit C-u W to add those to the same entry in the 
copy ring as the previous files. This builds up a virtual collection of 
files that you can then copy or move. Now go to the target directory and
hit X to move the copied files(从copy ring中移走） to that directory (i.e. they are deleted
from their original location) or Y to copy the files to the target directory (the originals remain where they were). 

注意D代表删除。


[dired-rainbow][131]

只有require或者use-package dired-rainbow才可以通过`C-h f RET dired-rainbow-define`找到该函数.

```
(use-package dired-rainbow
  :ensure t
  :preface
  (defconst my-dired-media-files-extensions
  '("mp3" "mp4" "MP3" "MP4" "avi" "mpg" "flv" "ogg")
  "Media files.")
  :config
  (dired-rainbow-define html "#4e9a06" ("htm" "html" "xhtml"))
  (dired-rainbow-define media "#ce5c00" my-dired-media-files-extensions)
; boring regexp due to lack of imagination
  (dired-rainbow-define log (:inherit default
                           :italic t) ".*\\.log")
; highlight executable files, but not directories
  (dired-rainbow-define-chmod executable-unix "Green" "-[rw-]+x.*"))

```

[dired-subtree][132]

flat-list to tree list
```
(use-package dired-subtree
  :config
  (bind-keys :map dired-mode-map
             ("i" . dired-subtree-insert)
             (";" . dired-subtree-remove)))
```


有了这个插件真的挺方便的，用起dired来，得心应手的.

在dired目录下使用i打开折叠目录(关闭折叠，展开)，;则可以用来折叠目录。


dired常用命令学习

```

* / 标记所有文件夹
u 去除标记
m 标记文件
R 移动或者重命名
C 复制
D 删除(d x)

```

### 65. org-mind-map 结合grpahviz创建思维导图

1. [graphviz][133]安装

cannot use unknown "org" back-end as a parent,的原因就是你没有安装graphviz

该错误原因并不是没有安装graphviz，而是因为没有在.orgConf.el添加`(require 'ox-org)`, 更进一步查看[官网FAQ][241]

2. [org-mind-map][134]安装，`M-x org-mind-map`

3. 在org文件中，使用org-mind-map-write-tree写出pdf文件


org范例文件
```
* 1. This is an org-mode tree with tags
:PROPERTIES:
:OMM-COLOR: GREEN
:OMM-LEGEND: Legend entry
:END:

** 1.1 Branch A 
*** Sub-Branch 1                                                    :@work:
*** Sub-Branch 2                                                    :crypt:
*** Sub-Branch 3                                                     :WORK:

** 1.2 Branch B


** 1.3 Branch C                                                     :@NCEPU:
** 1.4 Branch D 
* 2. Here is another tree
** 2.1 Branch One                                                     :HOLD:
** 2.2 Branch Two                                                     :java:
   [[Branch C]]
** 2.3 Branch Three                                                  :@home:

   [[Branch One][Another link]]

   [[Sub-Branch 1][Yet Another Link]]

```
使用[[]] 来访问标题。

org-mind-map-write: 输出的pdf文件

![map][135]
每次org-mind-map-write的tag颜色都是随机的。

突然有种想法，针对emacs的org文档，一个标题相当于一个节点，一个对象，可以存在很多的节点属性(C-c C-x p)，也可以贴上节点标签(c-c C-q)

这样就很方便对节点的显示做调整。

### 66. 有些topic不想让别人看到org-crypt（慎重加密！！!防止丢失！！！！）

windows下主要有两个软件(明白他们俩的作用)

1. kleopatra
2. GPA

加密分为两种方式对称和非对称，org[默认EasyPG包已经安装][141],也可以查找当地elpa包，查找epa-file.el即可。

但是EasyPG只是一个接口，用于调用[gnupg软件][142]，我直接[下载windows版本][143]

[linux版本参考coldnew][144], ubuntu使用`apt-get install gpg`
现在就不把该exe(太大,自己去官网下载，说明我有事先打开kleopatra-gnupg-win3.0软件

*本小段内容可以不做*，我的目的是在保存的过程中不需要重复输入密码，于是我创建了key-pair密匙，输入名字和邮箱，然后输入两次密码生成一个证书，并把gpg key ID设置到org-crypt-key中，默认是nil,则会每次保存时候提示你输入密码，再次输入密码！）


这样就可以加密了，默认windows安装之后gpg已放入path路径，所以打开cmd是可以找到gpg的)放入.emacs.d的customization文件夹了(aspell是放在其中了，解压缩即可使用)

[Emacs中使用GPG进行加密][140]，可了解ububtu创建gpg密匙，跨系统的时候有帮助。

.orgConf.el进行配置
```
(require 'epa-file)
;;base on the easyPG, org-crypt can crypt some entry or topic ,rather than
;; total file
(require 'org-crypt)                                      ;;
(org-crypt-use-before-save-magic)                         ;;
(setq org-tags-exclude-from-inheritance (quote("crypt"))) ;;
(setq org-crypt-key nil)       ;;
;;
```

加密效果:
![crypt][145]

不想加密，在你的本机只需要`M-x org-decrypt-entry`即可(也可以decrypt-entries全部去除加密),(不需要添加gpg后缀文件，只需要在对应的大标题下添加crypt tag即可，
会提醒输入密码（该密码任意，只需要配对即可，和你的kleopatra-gnupg-win3.0的证书密码可以不一样）

另外我特别烦每次保存都需要输入密码，于是在.orgConf做了一次修改,使用我自己的GPG key ID([加密用的密匙][144]，看之前那一段不需要做的部分)

![gnupg key id][146]

```
;(setq org-crypt-key nil)

(setq org-crypt-key "6285F68F72D6D3C2")
```

好处是，保存的时候不需要询问我的密码，而打开的时候则会询问我密码，密码就是我通过
Kleopatra创建证书时候输入两次密码时候对应的密码。还有好处是解密时候在你的本机上也不需要输入密码(在你的电脑里C:\Users\电脑名\AppData\Roaming\gnupg\文件夹下有
相关的密匙文件)。

加密是保密知识劳动成果的一种意识(扯淡!尿性！)

That's all, funny with enctypt files.


注意，由于重装系统删除了原先的asc证书文件，导致无法还原当时密钥，所以一些加密信息无法还原(干瞪眼），所以一定得从Kleopatra导出证书，并做好保存(相同用户名
相同邮箱 不同时间生成的密钥是完全不一样的，不可重复性)
并且修改.orgConf.el中关于org-crypt-key的16位加密数字。保持证书+密匙一致性！！

在kleopatra可以查找到我的注册名字的信息（那个信息应该是

```

workmad3 夸恩过时，至少对于当前gpg，如下? --allow-secret-key-import现在已废弃，不执行任何操作。

发生在我身上的是，我无法正常导出。 只是在做 gpg --export不足，因为它只导出公共密钥。 在导出密钥时，必须对它们进行

gpg --export-secret-keys >keyfile

他们更多的原因" 密钥不可用" 消息： gpg版本不匹配
```

在每一次打开`M-x org-decrypt-entry`都会提醒您输入密码

![gnucrypt][217]

也就是为了备份必须在Kleopatra做两部工作

1. 公匙备份，导出证书即可（服务器也会备份）（可被别人用于加密<2018-05-18 21:24> 的确如此！）
2. 私匙备份，导出私匙文件

进一步信息观看[baidu经验][216],明天你如何通过别人发布的公匙【也叫做证书】加密，然后把已加密的密文通过好友的密匙进行加密。

还有打开`GPA`

![GPA][218]

如果只是导入公匙到Kleopatra,那么再GPA显示的时候是没有黄色的私匙只有银色的公匙(一般如果kleopatra显示用户编号(user-Ids）未验证时候直接
邮件，确认是本人的ID即可，当然你可能删掉全部，重新导入GNU privary Assitant(GPA),不然emacs在进行加密的时候，可能显示不被信任的ID)

![secret][219]

所以这时候得从GPA导入私匙即可(我保存在我的电脑某一重要文件夹下，保证不丢失！)，很简单这里的import直接就可以导入密匙，这样
重新打开Kleopatra即可，说了这么多一定得注意两把钥匙。

<2018-07-15 13:51> 越来越喜欢org-mode+crypt模式！

<2018-07-25 14:17>
If you trust your Emacs session on your computer, you can have Emacs cache the password.
当然保存之后依然是加密码，`M-x org-decrypt-entry`就不需要在当前session输入密码了
``` org
(setq epa-file-cache-passphrase-for-symmetric-encryption t)
```


I have found that [ emacsdoctor ][353], `M-x doctor` will ask many questions about your status!

### 67. org-alert 提醒功能

org-alert Provides notifications for scheduled or deadlined agenda entries.

其实需要配套安装四个插件

1. gntp
2. [log4e][139]
3. [alert][137]
4. [org-alert][138]

只需要`M-x package install RET org-alert`即可，只不过有时候网络问题，可能
根本没安装上，所以需要逐个进行安装（这种情况是常见问题，反复安插件是常态）

在ui.el添加了

```
(require 'org-alert)
(setq alert-default-style 'libnotify)
(setq org-alert-interval 1800) ;; default 300s too short
```

`M-x org-alert-enable`即可（需不需要输入？）


### 68. gnus

相信你也查了很多的gnus，我找到了三个花时间的地方

1. 我使用126或者163邮箱，所以我得事先打开pop3/SMTP服务(打开邮箱，设置里面就有)，这样会要求你输入一个客户端的文本密码，这个是和登陆密码不一致（即使你输入一致也会叫你重新输入不一致，注意这个文本密码在下面的设置是有用的）
2. 有了文本密码了，现在就去`M-x gnus`?no,gnus会打开一个组，如果没有在~/.gnus.el设置select-first-method,就会报错。如果没有first-method就设置为nnnil，我是这样设置的，不然老是报错
3. ~/.gnus.el的~在windows是指`C:\Users\YeZhao\AppData\Roaming`
注意Pop3是110，smtp是25（gmail的设置又不一样 比如578）

下面是我的配置
```
 
(setq gnus-select-method '(nnnil)) 
(setq gnus-secondary-select-methods '((nntp "news.gwene.org")))  
;(setq gnus-secondary-select-methods '((nnml "")))   
(setq mail-sources  
'((pop :server "pop.126.com"  
:user "zh**key@126.com"  
:port 110  
:password "457***ran")))   ;;文本密码
(setq gnus-secondary-select-methods '((nnfolder "")))  
(setq user-full-name "Ye zhaoliang")  
(setq user-mail-address "zh***key@126.com")  
(setq smtpmail-auth-credentials  
'(("smtp.126.com"  
25  
"zh***key@126.com"  
"457***ran")))   ;;文本密码
(setq smtpmail-default-smtp-server "smtp.126.com")  
(setq smtpmail-smtp-server "smtp.126.com")  
(setq message-send-mail-function 'smtpmail-send-it)  
(set-language-environment 'Chinese-GB)  
(setq gnus-default-charset 'chinese-iso-8bit  
gnus-group-name-charset-group-alist '((".*" . chinese-iso-8bit))  
gnus-summary-show-article-charset-alist  
'((1 . chinese-iso-8bit)  
(2 . gbk)  
(3 . big5)  
(4 . utf-8))  
gnus-newsgroup-ignored-charsets  
'(unknown-8bit x-unknown iso-8859-1))  
;;(eval-after-load "mm-decode"  
;;'(progn  
;;(add-to-list 'mm-discouraged-alternatives "text/html")  
;;(add-to-list 'mm-discouraged-alternatives "text/richtext")))  
(setq gnus-default-subscribed-newsgroups  
'("gnu.emacs.help"  
"cn.comp.os.linux"  
"cn.bbs.comp.network.programming"  
"comp.std.c"  
"comp.protocols.tcp-ip"  
"comp.os.linux.development.system"  
"cn.bbs.comp.emacs"))  
  
;; * 键，帖子被拷贝到本地的 cache 中保存起来，再次 Meta-* 取消  
(setq gnus-use-cache 'passive)  
;; 可以保留同主体中已读邮件，把 'some 改为t可以下载所有文章  
(setq gnus-fetch-old-headers 'some)  
;; 保留已发邮件  
;; 在 group buffer 里键入`G m'，然后输入组名"mail.sent.mail", 接着是输入"nnfolder", 这个组就建好了，然后用同样的方式建立"mail.sent.news"组。  
(setq gnus-message-archive-group  
'((if (message-news-p)  
"nnfolder:mail.sent.news"  
"nnfolder:mail.sent.mail")))  
 
 (setq gnus-summary-line-format "%U%R%z%d %I%(%[ %F %] %s %)\n")
```

有了这个配置还不行，你得有一个~/.authinfo.gpg（我在66有配置了加密，gpg加密)
不然邮件发不出去。

```
machine smtp.126.com login zh***key@126.com password 45***ran port 25
machine pop.126.com login zh***key@126.com password 45***ran port 110

```

把上述邮箱改为你的邮箱，把密码改为你的文本密码（不要用登陆密码！）

到这里，你就可以使用`M-x gnus`

G m创建组
U 显示所有的组信息
m 创建邮件

ok, 简单使用就这样！


### 69. nyan-mode 让小猫左右扭起来

[nyan-mode][147]

简单配置ui.el
```
(nyan-mode t)

```

这样在你的statusline就出现了彩色尾迹的小猫，每当你的cursor下移cat往右走，cursor上移往左走。


### 70. 修正journal的模板创建问题

在[标题56][148]留下一个bug，终于解决了.

.orgConf.el配置如下,

```

(defvar org-jou-dir "~/.emacs.d/GTD/orgBoss/Journal/"
"gtd org files location")

;(setq org-default-notes-file (expand-file-name "index.org" org-agenda-dir))
(setq current-time-file (expand-file-name (format-time-string "%Y%m%d") org-jou-dir))

 ("j" "Journal Note"
        ; entry (file+headline current-time-file "Write it!Pls") ;; it works
         entry (file current-time-file )
         "* Event: %?\n\n  %i\n\n  From: %a"
         :empty-lines 1 )
```

用函数的方式返回不行，但是用setq的方式确实可以,这样就可以使用calendar（ij插入当天的记录，又可以使用ctrl-c c Ret j产生Event)。Good!



### 71. org-bookmark-heading

github: [org-bookmark-heading][152]

我们在emacs会使用`C-x r m `来标记一个文件到bookmark系统，通过`C-x r l`或者`C-x r b`来跳转

现在我们想把org文件里面的heading也当作一个文件的方式，写入到bookmark系统，类似文件的方式。

### 72. 经典的org clock操作和拓展


[org-clock-convienience][154]教会你如何在agenda画面中修改由于某件事情耽搁（但是你又是一个时间控，无时无刻都在用org clock-in 模式)，这样你就需要多添加一些时间，
延长或者减少了,但是不用

[org-clock-budget][153]教会你的是如何给一件事情分配多少时间，并且安排很多星期去做，
如果一个星期没做完，那就下星期多分配点。

<2017-11-01 19:53> 现在迷上了clock，实现clock-in功能，然后在emacs的status-bar就会保留你正在进行clock的entry
在同一文件使用`C-c C-x C-j`实现跳转(工作流:捕捉一个todo，直接进行，然后等结束后才`C-c C-c`停止捕获,原先工作流是先创建不管clock in问题)。

<2018-04-25 19:24>再次学习！只针对org mode的情况才能使用`C-c C-x C-j`

![clock-in][160]

在对应的headline(一般是带todo标签）进行clock-in(`C-c C-x C-i`),clock-out(`C-c C-x C-o`)(典型工作流),如果你觉得该headline已经做完了，
那就clock-out 并进行`C-c C-x C-r` 表示你已经做完了

如果在一个大标题下，使用clock review的话，就可以针对所有的子标题,每次只能有一个clock（不能有多个clock记录，你一个人做不了多件事情，
但是可以在一个大标题下)（<2017-11-03 11:19> from now on ,开始clock生活)

所以在org-mode中有一个Effort-All的变量，他代表的意思是一次clock-in-out的时间倒计时
```
(add-to-list 'org-global-properties
      '("Effort_ALL". "0:10 0:15 0:30 1:00 2:00 3:00 4:00 6:00 8:00 12:00 15:00 20:00"))
```

一般人定的最长时间4小时就不错，长期保持不变做一件事情，一般是科研方面或者coding activity.

### 73. 关于时间格式的说明

I have seen the time format about [the agenda here][156], and I want to add it in the agenda view.
so I visit the [link about the time format][155].

在.orgConf.el中add the time and now,; When there's a cider error, show its buffer and switch to it


1. when time is surrounded  with square, it means unactive,
   when time is surrounded with angle bracket, it means active, in addition ,if add in the headline, it 
   will show todo headline in the agenda view

2. C-c C-x C-t can change the style of time format

`M-x nowTimePoint` insert time point
`M-x today` insert current day time
`M-x tommorow` insert tomorrow time
`M-x yesterday` insert yesterday time


```

(defun now ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%-I:%M %p"))
)

(defun nowTimePoint ()
  "Insert string for the current time formatted like '2:34 PM'."
  (interactive)                 ; permit invocation in minibuffer
  (insert (format-time-string "%H:%M"))
)



(defun today ()
  "Insert string for today's date nicely formatted in American style,
e.g. Sunday, September 17, 2000."
  (interactive)                 ; permit invocation in minibuffer
  ;(insert (format-time-string "%A, %B %e, %Y"))
  (insert (format-time-string "<%Y-%m-%d %H:%M>"))
)

```

### 74.rust的冲动

简单
[rust github][https://github.com/rust-lang/rust]

[rust mode][157]


[rust-example][158]

[rust-cargo][159] 类似于leiningen maven

放弃他

### 75. 删掉没有必要的remember

在orgConf中 删掉关于muse planner, remember三个包，简化system 大小。

elisp编写技巧(<2018-05-08 22:39> [emacs-lisp-guide][257])


```
C-M-d   Move down into a list(进入）
C-M-u   Move up outof a list(跳出)

The usual way to access the property list is to specify a name and ask what value corresponds to it.
```

快速编写括号相关的代码。

move down into a list ,the point will jump into the nearest balanced expression of parentheses ahead of the point ....

Inside the newer verions of Emacs, you can use `C-M-u`
inside a string to jump to the opening quote


Also `C-M-k` kill the balanced s-expression

list内部还有同级操作

```
C-M-n  move forward to the next list
C-M-p  move backward to the previous list
```

### 76. Emacs到底为你做了什么？

1. clojure: 使用cider结合jvm产生一个可编译平台
   2. 使用paredit快速编写括号相关的forms
   3. 使用cljr-refactor快速重构
   4. 使用highlight进行着色
   
   
2. yasnippet帮你快速打出相关的语句(一般是敲入key名字然后tab完成缩写补全）
   1. clojure相关的snippets
   2. elisp相关的snippets
   3. 不同于sotclojure或者sotlisp使用def空格(不需要tab)等完成缩写
   
3. company为你提供一些completion word

4. expand-region帮你快速选择要给text-object
他真的为你做的就只有这些？

org-mode是一个超级好的gtd工具，每天都利用它帮你完成事情，帮你记录，提醒你该做什么？

额外再补充……



### 77. Emacs encode system乱码

```
;;;windows system
;;fuck notify you for settning https://github.com/sriramkswamy/ryo-emacs/blob/master/init.el
(setq coding-system-for-read 'utf-8)										  	; use utf-8 by default for reading
(setq coding-system-for-write 'utf-8)
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq-default pathname-coding-system 'utf-8)
(setq default-process-coding-system 
            '(utf-8 . utf-8))
(set-buffer-file-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;(set-clipboard-coding-system 'utf-8)

```

如果(set-clipboard-coding-system 'utf-8)可能导致复制时候出现乱码，raw-text保存。

### 78. cool operation on editing clojure file

1. fe . you use wishful thinking to write the upper code,
and when you want to implement the internal function,just fe.
2. M+Enter. you edit in the let block, then you can add parathesis
   in your new line.
3. M+X mc/mark all like this. When visual select the word or
parase, then `C-c C-<`(<2018-07-25 15:43>替换为 `C-c M-. .或者C-c M-. M-. 或者C-c M-. C-a` 不需要选择word)


### 79. ediff的强大之处

支持三个文档同时比较， 支持patch文件的导出(暂时不会),详细参考[Emacs 之 ediff 学习][168]以及[Vimdiff 使用][169]

常用命令

```
M-x ediff   : 选择两个文件或者三个文件进行比较
然后可以在ediff窗口中，摁下space或者n表示向下导航差别区域   p代表向上导航

！ 代表重新比较

| 代表垂直模式

q 退出

E 打开ediff文档

v 向下翻滚

V 向上翻滚

a 把Buffer-A内容复制到Buffer-B

b 把Buffer-B的内容复制到Buffer-A

w a 保存Buffer-a到磁盘

w b 保存Buffer-b到磁盘


r a  回复Buffer-A 差异区域中被修改的内容
```


### 80 Editing arts

首先阅读[你是如何成为Lisp程序员][170]，会看到lisp语言的强大和博大精深，
重点提取Bob Glickstein 曾经写过一本[《Writing GNU Emacs Extensions》][171]

然后开始讲讲[editing的故事：Seven habits of effective text editing ][172]，

背景：

    Most time is spent reading, checking for errors and looking for the right place to work on, rather than inserting new text or changing it. Navigating through the text is done very often, thus you should learn how to do that quickly.

    Quite often you will want to search for some text you know is there. Or look at all lines where a certain word or phrase is used. You could simply use the search command /pattern to find the text,
    
    组织资料的过程中，占据最大时间块的工作是查资料。
1. 单文件editing
   2. navigation needs much more than editing(looking is the main work: function, structure, typedefs, modules, files, results ,excels, ppts)
   3. repeat the work with dot
   4. use abbr fix writing error
   5. structured editing file
2. 多文件editing
3. You know you need to invest time to learn a skill(just write: learn to new commands and turn them into a habit,20% commands make 80% works , 20%time makes 80% profits  , 20% people makes 80% contributions)(repeat the 20% command day and night, now and then, finally automated)
If you don't expect having to do it again,don't try to optimise it. 

额外的vim阅读 

+ [learn vim the hardway][172]
+ [learn vim progressly][173]


### 81. 再次学习link


1. 定义锚点
```
#<<hello>>

注意这边说的都是针对orgmode文件(*.org结尾的文件！！！)<2018-05-16 13:17>  下面均有效

[[hello][hello内部链接]

通过C-c C-o打开链接(open)<2018-05-22 23:42>再次学习
通过C-c C-l (打开保存的链接, 很强大，打开各种链接）
通过C-c l(org-insert-link 然后可以通过C-c C-l使用 可以创建各种连接，直接跳出来，很是方便，爱上了org-mode <2018-04-23 17:38> ]
  <2018-06-27 09:49> <2018-07-24 16:27> 一直想着实现vimwiki click <CR> to create file links
```


```

file:~/code/main.c:255
file:~/xx.org::MyTarget (找到目标<<My Target>>'
```

2. 定义脚注

```

定义脚注  [fn:footprint1]

引用脚注  [[fn:footprint1][脚注1]]
```

注意直接在字符串后面[C-c C-x f][269]即可

想要看引用处，直接`C-c C-c`即可跳转到脚注点

另外可以拓展了解[vimwiki的跳转原理][270],这也是我喜欢vimwiki的地方

3. 再次提及info

```

info:org:External%20links
```


[vim-plugins is good things][174]: 叶， you need to practice it!
使用`\ntw`书写个人信息存储到$HOME\vimfiles\perl-support\perl.templates(修改位置也可以)中，然后使用`\ntr`
重新载入即可。

### 82. ruby的简单包加载

放在custimations文件夹下的ruby-end.el，通过init.el load进去emacs系统
当你敲入`def`之后自动补全`end`

```
load 'setup-ruby-mode.el'
load 'ruby-end.el'

```


### 83. python 编译器集成到emacs

参考[用Emacs进行Python开发][175]

1. 安装python本身所需要的插件
```
 pip install ipython jedi flake8 importmagic autopep8 yapf
```

<2018-09-21 19:29> 后来我知道[jedi][391]是一个静态分析器
大家知道[SirVer/utisnips][388]是一个不错的python vim库，当然在当前咱们的emacs库中也是存在的，为什么？
因为我们有[yasnippet][389], 所以能达到utisnips类似的效果。

Vim中，可以使用[jedi-vim][390]替换python-mode,
2. 安装emacs的插件

配置下载仓库
```
(setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                         ("melpa-stable1" . "http://elpa.emacs-china.org/melpa-stable/")))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)
```

然后在`setup-python.el`中添加codes below,其中(electric-pair-mode t)目的
是配对小括号，大括号等

```
;;; setup-python.el --- 
;;;(elpy-enable)

(use-package python-mode
  :mode (("SConstruct\\'" . python-mode)
         ("SConscript\\'" . python-mode)
         ("\\.py\\'"      . python-mode))
  :config
  (use-package elpy
    :init
    (elpy-enable)
    (elpy-use-ipython)
    (electric-pair-mode t)
    ;; use flycheck not flymake with elpy
    (when (require 'flycheck nil t)
      (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
      (add-hook 'elpy-mode-hook 'flycheck-mode))))

```



3. 添加了一些snippets

```
for tab === >   for ... in ... :
f tab   === >   def ,,  : 
fd tab  === >    def .. : ""
cl tab  === >   class name.. :
ass tab === >    assert
ae tab  === >    self.asserEqual()
ifm tab === >    if __name__ == '__main__': ${1:main()}
main tab ===>     def main(): $0
from tab == >    from .. import ..
if tab ==>
ife tab ==>
li tab  ==>     [i for exp in list]
lam tab ==>      lambda ${1:x}: $0
r tab ==> return $0
reg tab ==> re.compiler
wh tab ==> whil ${1:True}
with tab ==> with ${1:expr}${2: as ${3:alias}}: 
script tab ==> ifm+ main 的合体
str tab    ==> def __str__(self): $0
setup tab  ==>  一堆。。。
p tab ==> 经常用
try tab ==> try: ...
tryelse


plt tab ==> import matplotlib.pyplot as plt
np  tab ==> import numpy as np


```

4. pip 豆瓣源配置


路径: `C:\Users\{Computename}\pip`
内容:
```

[global]
timeout = 60
index-url = http://pypi.douban.com/simple
trusted-host = pypi.douban.com

```


这样直接pip install [包名]即可
不需要 `pip install -i https://pypi.doubanio.com/simple/ numpy `


[python练习实例][176]
```
# -*- coding: UTF-8 -*-

def a(n):
   L = []
   for i in range(2,n-1):
       L.append(n%i)
   if  0 not in L:
      return True
print filter(a,range(101,200))
```

### 84 everything and totalCMD

everything:

```
1. 工具---选项---上下文菜单
2. 打开(文件夹):
  $exec("d:\totalcmd\TOTALCMD.EXE" /O /P=L /L="%1")

3. 打开路径
  $exec("d:\totalcmd\TOTALCMD.EXE" /O /P=L /L="%1")
/O  如果存在进程则激活不存在则创建进程
/P=L 激活TC的左侧列表
/L= 设置左侧的路径
```

TotalCmd:

注意配合快速搜索 Ctrl+Alt+字母

```
1. 配置---选项--其他
2. Shift+F 快捷键--- em_usercmd1
命令: D:\Program Files (x86)\Everything\Everything.exe
参数：-search "%P" 
```


### 85. 记录和查询记录

1. 每次记录的时候添加tag, 归好类，事先想好下一次你会怎么找该条记录.

`C-c C-q` 添加标题的tag，一把我会在calendar下面摁下`ij`添加

```
global-set-key (kbd "C-c f y") 'journal-file-yesterday
(global-set-key (kbd "C-c f L") 'journal-last-year)
(global-set-key (kbd "C-c f j") 'journal-file-today)
```

在calendar-mode中默认提供了
 
```
i w  weeek
i d  day[在dairy.org插入当前时间]
i y  year
i m  monthly 
a    list all the holiday
```
但是这些只是在diary中插入数据，而`i j`则会创建一个entry文件，然后只记录当天的。

`(add-to-list 'auto-mode-alist '(".*/[0-9]*$" . org-mode))` 表示对数字文件添加org-mode形式。

上述功能其实是[org-journal][178]提供的功能，而在当前的文档中，需要简单[journal-file-today][181] .orgConf.el.

[tag-alist:][182]
```

(setq org-tag-alist '((:startgroup . nil)
                      ("@Company" . ?o)
                      ("@Home" . ?H)
                      ("@NCEPU" . ?n)
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)
                      ("WAITING" . ?w)
                      ("HOLD" . ?h)
                      
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)
                      ("Oracle" . ?O)
                      ("sqlite" . ?S)
                      ("Mysql" . ?Q)
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)
                      ("EnglishPaper" . ?l) 
                      ("java" . ?j)
                      ("perl" . ?p)
                      ("Linux" . ?L)
                      ("matlab" . ?m)
                      ("Fortran" . ?f)
                      ("Vim" . ?v)
                      ("clojure" . ?J)
                      ("scheme" . ?s)
                      ("python" . ?y)
                      ("ruby" . ?r)
                      ("emacslisp" . ?e)
                      ("git" . ?G)
                      ("Docker" . ?D)
                      ("CFD" . ?F)
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)

                      ("crypt" . ?C)
                      (:endgroup . nil)
                      (:newline)
                      (:startgroup . nil)


                      ("芝麻" . ?z)
                      ("橘子" . ?J)
                      ("西瓜" . ?x)
                      ("大象" . ?X)
                      ("大山" . ?M)
                      ("地球" . ?E)
                      ("太阳" . ?T)
                      ("银河系" . ?Y)
                      ("宇宙" . ?Z) 
                      (:endgroup . nil)

                      (:newline)
                      (:startgroup . nil)
                      ("multiAxis" . ?t)
                      ("graduation" . ?g)
                      (:endgroup . nil)

                      (:newline)
                      (:startgroup . nil)
                      ("紧急重要" . ?a)
                      ("紧急不重要" . ?b)
                      ("不紧急重要" . ?c)
                      ("不紧急不重要" . ?d)
                      (:endgroup . nil)
                      ))
                      
                      

```
2. 查询的时候执行`C-c a m` 查找对那个的tag即可查到你需要的，很方便的一种管理系统。比如:`芝麻`。


### 86. funny insert source block

```
(add-hook 'org-mode-hook '(lambda ()
                            ;; turn on flyspell-mode by default
                            (flyspell-mode 1)
                            ;; C-TAB for expanding
                            (local-set-key (kbd "C-<tab>")
                                           'yas/expand-from-trigger-key)
                            ;; keybinding for editing source code blocks
                            (local-set-key (kbd "C-c s e")
                                           'org-edit-src-code)
                            ;; keybinding for inserting code blocks
                            (local-set-key (kbd "C-c s i")
                                           'org-insert-src-block)
                            ))
```

[org-edit-src-code][180]
下次想要在你的org添加note的时候，只要`C-c s i`即可,会打开一个输入窗口`C-c '` 结束输入。 


### 87. shourcut the common files 

Add [defshortcut code][179] inside the .orgConf.el
```
(my/defshortcut ?i "~/.emacs.d/GTD/newgtd.org")
(my/defshortcut ?f "~/.emacs.d/GTD/orgBoss/Film/film.org")
(my/defshortcut ?v "~/.emacs.d/GTD/orgBoss/Vocab/vocab.org")
(my/defshortcut ?s "~/.emacs.d/GTD/orgBoss/Someday/someday.org")
(my/defshortcut ?S "~/.emacs.d/GTD/orgBoss/Site/www.site.org")
(my/defshortcut ?B "~/.emacs.d/GTD/orgBoss/Book/book.org")
(my/defshortcut ?c "~/.emacs.d/GTD/orgBoss/Clipboard/clojureLearn.org")
 (my/defshortcut ?b "~/.emacs.d/GTD/orgBoss/business/business.org")
(my/defshortcut ?e "~/.emacs.d/GTD/orgBoss/code/codes.org")
(my/defshortcut ?W "~/.emacs.d/GTD/orgBoss/Site/blog.org")
(my/defshortcut ?j "~/.emacs.d/GTD/orgBoss/Journal/journal.org")
(my/defshortcut ?I "~/.emacs.d/GTD/orgBoss/IDEA/idea.org")
(my/defshortcut ?d "~/.emacs.d/GTD/orgBoss/DailyReview/daily.org")
(my/defshortcut ?l "~/.emacs.d/GTD/orgBoss/learning.org")
(my/defshortcut ?q "~/.emacs.d/GTD/orgBoss/questions.org")
(my/defshortcut ?w "~/.emacs.d/GTD/writing.org")
(my/defshortcut ?p "~/.emacs.d/GTD/phd1.org")
(my/defshortcut ?D "~/.emacs.d/GTD/Dissertation.org")
(my/defshortcut ?n "~/.emacs.d/GTD/orgBoss/Note/notes.org")

```

然后你就可以敲入`C-x r j` ，输入对应字母，跳转到对应的文件下。

<2018-09-20 18:21> `C-x r s` 表示复制内容到对应的文件内(有用的快捷键)。


### 88. magit cannot commit

when Commit the newest repos, error occurs, while actually I have git config --global.

```

fatal unable to auto-detect email address (got "some wrong email")
```

Solution:

because emacs see `C:\Users\yzl\AppData\Roaming` as the home directory
so you should copy `.gitConfig` inside it.  Idea came from [ fatal unable to auto-detect email address][183].


### 89. 自定义agenda-view


[storing search][186],针对所有org-agenda-files.
```
(setq org-agenda-custom-commands
      '(("x" agenda)
        ("y" agenda*)
        ("w" todo "WAITING")
        ("W" todo-tree "WAITING")
        ("u" tags "+boss-urgent")
        ("v" tags-todo "+boss-urgent")
        ("U" tags-tree "+boss-urgent")
        ("f" occur-tree "\\<FIXME\\>")
        ("h" . "HOME+Name tags searches") ; description for "h" prefix
        ("hl" tags "+home+Lisa")
        ("hp" tags "+home+Peter")
        ("hk" tags "+home+Kim")))
```

最后修订为

```
(setq org-agenda-custom-commands
      '(("O" "Office block agenda"
         ((agenda "" ((org-agenda-ndays 1))) 
                      ;; limits the agenda display to a single day
          (tags-todo "+PRIORITY=\"A\"")
          (tags-todo "computer|office|phone")
          (tags "project+CATEGORY=\"elephants\"")
          ;(tags "review" ((org-agenda-files '("~/org/circuspeanuts.org"))))
                          ;; limits the tag search to the file circuspeanuts.org
          (todo "WAITING"))
         ((org-agenda-compact-blocks t))) ;; options set here apply to the entire block
        ;; ...other commands here
        ("g" . "Go to somewhere tags search")
        ("go" "Office" 
         (tags "@Company")
         (tags "@NCEPU"))
        ("gh" "Home" tags "@Home")
        ("gm" "School" tags "@NCEPU")

        ("p" . "Priorities")
        ("pa" "A items" tags-todo "+PRIORITY=\"A\"")
        ("pb" "B items" tags-todo "+PRIORITY=\"B\"")
        ("pc" "C items" tags-todo "+PRIORITY=\"C\"")

        ("z" . "概念宽度")
        ("zz"  "芝麻" tags "+芝麻")
        ("zj"  "橘子" tags "+橘子")
        ("zg"  "西瓜" tags "+西瓜")
        ("zd"  "大象" tags "+大象")
        ("zq"  "地球" tags "+地球")
        ("zt"  "太阳" tags "+太阳")
        ("zh"  "银河系" tags "+银河系")
        ("zy"  "宇宙" tags "+宇宙")

        ("j" "加密" tags "+crypt")
        ("s" . "重要程度" )
        ("sa"  "紧急重要" tags "+紧急重要")
        ("sb" "紧急不重要" tags "+紧急不重要")
        ("sc" "不紧急重要" tags "+不紧急重要")
        ("sd" "不紧急不重要" tags "+不紧急不重要") 

        ("d" . "数据库")
        ("do" "Oracle" tags "+Oracle")
        ("ds" "sqlite" tags "+sqlite")
        ("dm" "Mysql" tags "+Mysql")
        
        ("l" . "语言")
        ("ll" "EnglishPaper" tags "+EnglishPaper" ) 
        ("lj" "java" tags "+java")
        ("lp" "perl" tags "+perl")
        ("ln" "Linux" tags "+Linux")
        ("lm" "matlab" tags "+matlab")
        ("lf" "Fortran" tags "+Fortran")
        ("lv" "Vim" tags "+Vim" )
        ("lo" "clojure" tags "+clojure")
        ("ls" "scheme" tags "+scheme")
        ("lp" "python" tags "+python")
        ("lr" "ruby" tags "+ruby")
        ("le" "emacslisp" tags "+emacslisp")
        ("lg" "git" tags "+git")
        ("ld" "Docker" tags "+Docker")
        ("lc" "CFD" tags "+CFD")
        ))
```

### 90. 自定义了全局标记和跳转（写文章必备）C-c w|e

`C-c %`摁下之后，状态栏会提醒使用`C-c *`进行跳转回去。

```
(global-set-key (kbd "C-c *") 'org-mark-ring-goto)
(global-set-key (kbd "C-c %") 'org-mark-ring-push)
```

但是后来放弃了，因为`C-c *`会使得org文件内的文字变成一个最大标题所以舍去
改为

```

(global-set-key (kbd "C-c e") 'org-mark-ring-goto)
(global-set-key (kbd "C-c w") 'org-mark-ring-push)

```

这样我想起vim的[三个黄金操作之learn vim progressively][187]
```

        % : Go to the corresponding (, {, [.
        * (resp. #) : go to next (resp. previous) occurrence of the word under the cursor
```

[升级版操作:vim as IDE][188]


### 91. 项目中搜索内容和文件(现在才看到了你的美，妖娆，火辣)

`C-c p f` 项目中搜索文件(嘿嘿，也可以用`C-c k` 调用counsel-ag也是一样的,默认至少输入3个字符)

`C-c p p ` 切换项目

`C-c p s s` 项目中搜索文件内容,已经把ag.exe拷贝到~/.emacs.d中（支持中文， 不需要额外添加到path目录），并安装了`M-x package-install ag`文件。
<2018-06-14 15:57> 确认支持中文,捡到宝的感觉,难道是更新的缘故!


<2018-09-22 17:22>可否替换为rg.exe，据说比ag快点，现在库中也集成了[color-rg][396] 见标题149.
安装`M-x package-install projectile-ripgrep`, 就可以使用`C-c p s r`

`C-c k`也可以搜索但是不支持中文
得经常看看[Counsel-projectile文档][191]

删除editing.el的`C-s`配置，改用[swiper][27]的配置

`C-s` 使用swiper正向搜索 ,注意搜索`\!\[ ` 会弹出所有的img名字相关的插入位置，很方便查找。

`C-c C-r` 使用swiper反向搜索


### 92. update the elpa

don't use stable!
```
;; load emacs 24's package system. Add MELPA repository.
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))
```

`M-x list-packages` ----> `u` ----> `x`  update


### 93. ag  or rg  or pt

[dumb-jump][193] with [ag][195] or [rg][192]


ag只要添加到path路径即可【windows系统】

如果dumb-jump出现问题，可以调试的，参考[问题168][197]. 

注意如果你使用dumb-jump,他支持你常用的java，perl(bash等)，fortran，clojure,emacs-lisp,scheme,R,c/c++,OCaml等
但是他是类似于项目的概念，如果你的一个项目没有`.dumbjump`,`.git`,`.hg`,`.svn`,`.bzr`,`
Makefile`,`PkgInfo`,`.projectile`,`.hg`等信息,那么文件夹顶层就不会被当作项目project来看待，dumb-jump会把
上一次的项目目录当作你当前文件，这样查找code可能找不到了(真有问题debug一下） 

默认查找路径:(dumb-jump will automatically look for a project root)
```

(setq dumb-jump-default-project "~/code") to change default project if one is not found (defaults to ~)
```

dumbjump特殊查找方法(类似.gitignore写法 +代表添加，-代表从搜索路径中剔除)

```
Example .dumbjump

-tests
-node_modules
-build
-images
+../some-lib/src
+/usr/lib/src

```

小结一下，选择ag模式下的dumb-jump(`M-g j`), 在当前emacs编辑系统中注意projectile.bookmarks.el文件，保存着打开文件夹的路径。

[dumb-diff][194], 很好玩的，`C-c d`打开一个3栏界面，上排两个为两个buffer比较，下排为比较结果。

![dumb-diff][196]


.orgConf.el , 很有意思的dumb-jump go and back!! Very good for looking source code.

```
(global-set-key (kbd "C-c e") 'org-mark-ring-goto)
(global-set-key (kbd "C-c w") 'org-mark-ring-push)


;;https://github.com/jacktasia/dumb-jump
(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g b" . dumb-jump-back)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
;;(setq dumb-jump-debug t)   ;;when something wrong with dumb-jump,uncomment it 
(setq dumb-jump-force-searcher 'ag)
  :ensure)


;;https://github.com/jacktasia/dumb-diff
(use-package dumb-diff
  :bind (("C-c d" . dumb-diff)
         ("C-c 1" . dumb-diff-set-region-as-buffer1)
         ("C-c 2" . dumb-diff-set-region-as-buffer2)
         ("C-c q" . dumb-diff-quit))
  :ensure t)

```

而在vim中你可以使用[CtrlpFunc][203]来定义(cword表示当前光标下单词，

```
nnoremap <Leader>fu :CtrlPFunky<Cr>
" narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
```

类似的还比如在ag中的使用`expand("<cword>")`
```



nmap <leader>q :Ag <c-r>=expand("<cword>")<cr><cr>
nnoremap <space>/ :Ag 

```

类似的还有vim的 [vim-asterisk][204],可以使用`g*`的功能进行查找

[rg ripgrep][192]

[pt : the platinum_searcher][198]: 基于go语言编写的代码搜索工具，据测试略微比ag快点。


### 94. yasnippet的工作原理

在你的snippets底下有很多的\*-mode(比如c++-mode c-mode  clojure-mode ..) ,当你编辑的文档是c则会触发c-mode等
所以其实是[yasnippet][201]会去think what major mode of the current file!!! 根据major mode来定会你的snippet/\*-mode文件夹



[yasnippet效果欣赏][199]:特殊的代码补全工具


嘿嘿  [yasnippet][201]中不同mode的[snippets][200]

比如当前我的markdown-mode，我只要写入`ol`,摁下tab键，自动插入内容


```
1. Text
2. 
```

再比如，我敲下`rimg ` ,摁下tab键，自动键入如下内容

```
![Alt Text][] 

```

再次回顾发现，敲入`h1 tab`,`h2 tab`,`h3 tab`[类似的markdow mode]等，可以快速创建header in org extension files
[工作逻辑:h1 tab,input header name,done].

还有快速插入dot脚本，比如`graphviz tab,然后done`

使用`:d tab`快速插入代码快字段

easy for  life!!!


在markdown mode很重要的是`- + tab` 插入列表


最重要是学习方法: 去看看每个snippets文件夹下的脚本，然后写在对应的拓展文件下，敲上去试试即可!


为此，还使用了[ivy-yasnippet][318],针对一定的mode来产生对应的snippets，很方便啊！
<2018-06-24 21:06> 
<2018-07-02 14:53>

为了好玩，也安装了[Counsel-world-clock][319], 但是觉得不太好用！


----------


### 95. emacs录制宏

在vim中你可以使用`qa`或者`qb`等录制一个名字为a或者b的宏，并通过`@a`或者`@b`来执行 也可以通过`100@a`进行100次执行[<2018-05-03 22:38> 由于引入了evil-mode也可以在emacs使用该方式录制键盘宏]

而在emacs中，你可以通过`C-x(` 开始录制， 通过`C-x)`结束录制，并通过`C-x e`执行录制宏，还可以通过`C-u 9 C-x e`或者`C-9 C-x e` 进行9次执行等。注意可以通过`M-x name-last-kbd-macro {Your macro name}`来持久化你的宏，然后通过`M-x {Your macro name}`进行调用。

类似的重复性概念，还不如你可以`C-n`多次下移光标，但同时也可以通过`C-9 C-n`进行9行下移，对于阅读代码有帮助，当然也可以用`C-v`或者`M-v`进行正向和反向半屏阅读。    

### 96. evil-surround




[evil-surround][205]对应[vim-surround][206]

[vim-surround][206]一般配合vim的快操作, 而[evil-surround][205]一般配合[expand-region][12],

只不过有一点不友好，需要[evil][211]当做vi layer( <2018-02-20 14:29> 至此改用vim默认启动模式)。

```
Add surrounding

You can surround in visual-state with S<textobject> or gS<textobject>. Or in normal-state with ys<textobject> or yS<textobject>.
Change surrounding

You can change a surrounding with cs<old-textobject><new-textobject>.
Delete surrounding

You can delete a surrounding with ds<textobject>.
```



```
我通常用expand-region选中一段文本,然后按 S 或者 M-x evil-surround-region ,再按任意字符(比如双引号)就可以在文本首尾两端附加该字符.

当然它也支持修改删除操作.

之前提到的text object也完美支持.
```

evil额外插件(C-z快速切换回emacs模式—）

```
C-z runs the command evil-exit-emacs-state (found in
evil-emacs-state-map), which is an interactive compiled Lisp function
in ‘evil-commands.el’.

It is bound to C-z.

```

[evil-visualstar][213]

```
Add (global-evil-visualstar-mode) to your configuration.

Make a visual selection with v or V, and then hit * to search that selection forward, or # to search that selection backward.

If the evil-visualstar/persistent option is not nil, visual-state will remain in effect, allowing for repeated * or #.
```

[evil-matchit][212]

```
本质就是你当前焦点在文件的某个位置A,你按 % 或者 M-x evilmi-jump-items,焦点移到位置B,你再按同样的键,又回到了位置A.

比如在一个HTML文件中,你就可以在 <body> 和 </body> 间跳来跳去.其他各种编程语言都支持.
```

[evil-escape][214]

还没用起来！
```

The key sequence can be customized with the variable evil-escape-key-sequence. For instance to change it for jk:

setq-default evil-escape-key-sequence "jk")


(global-set-key (kbd "C-c C-g") 'evil-escape)
```


### 97. git-gutter

[emacs-git-gutter][207]模仿优秀的vim插件[vim-git-gutter][208]， 方便观察文件哪边发生了变化比如


![git-gutter][209] 


### 98. git-timemachine

使用前提： 只能在emacs-mode情况使用，evil-mode出现问题


一个小git插件，显示一个文件的所有版本信息

[git-timemachine][210]

在非evil-mode情况下，可以在当前的navigation history  file使用以下命令


``` org
| 命令 | 说明                                                                    |
|------+-------------------------------------------------------------------------|
| p    | Visit previous historic version                                         |
| n    | Visit next historic version                                             |
| w    | Copy the abbreviated hash of the current historic version               |
| W    | Copy the full hash of the current historic version                      |
| g    | Goto nth revision                                                       |
| t    | Goto revision by selected commit message                                |
| q    | Exit the time machine.                                                  |
| b    | Run magit-blame on the currently visited revision (if magit available). |

```

还可以使用M-x git-timemachine show nth version: 指定具体某个版本


`M-x git-timemachine`


### 99. window-numbering

[window-numbering][215] , 在打开多个多个窗口的时候方便通过`M-0 M-1` 进行切换。


### 100. 文件journal过多会报错

error:

```
 apply : cannot create file process . too many file open . so some files need to archive
```
这说明需要定期把journal放到备份文件夹，重新archive进入一阶段文件放入到一个大文件中，进而减小文件数量（人一辈子也就几十本）
所以我就写了个小perl脚本，读取一阶段文件，然后存入到一个文件夹中，注意把原先文件移到GTD文件夹的bakupJournal文件夹即可，别
放在orgBoss或者其中即可

solution:

```
perl momthSummary.pl
```



1. outputFile, you need to change the name into significant name
2. 20171[01]* you need to check all the files need to be archived

```
use strict;
use warnings;
use utf8;

#print "$_\n" foreach <"2017*">;

##  First place need to be modified     100011 express 10 to 11
my	$CollectFile_file_name = '2017100011';# output file name



open  my $CollectFile, '>', $CollectFile_file_name
    or die  "$0 : failed to open  output file '$CollectFile_file_name' : $!\n";


##  second place need to be modified 
foreach my $file ( <"20171[01]*"> ) {

    print $CollectFile "## $file -----------------------------------\n";

    
    my	$IntoFile_file_name = $file;#  input file name

    open  my $IntoFile, '<', $IntoFile_file_name
        or die  "$0 : failed to open  input file '$IntoFile_file_name' : $!\n";



    while ( <$IntoFile> ) {
        print $CollectFile "$_";
    }
    ##    print $CollectFile <$IntoFile>;
    # # while ( <$file> ) {
    #     print "$_\n";
    # }
    close  $IntoFile
        or warn "$0 : failed to close input file '$IntoFile_file_name' : $!\n";


}
close  $CollectFile
    or warn "$0 : failed to close output file '$CollectFile_file_name' : $!\n";




```

### 101. sbcl(quicklisp) + slime 构建lisp平台

怀念一下lisp，重新在emacs配置一下，原先使用[clisp][222]，今天查了一下发现自从2010年7月它都没update过，还是单线程，所以改用[sbcl][223],
而在emacs可以使用slime很好的调用sbcl或者clisp.


#### sbcl侧配置

1. 下载 [quicklisp][224]
2. 安装quicklisp,参照quicklisp官网

```
sbcl --load quicklisp.lisp

(quicklisp-quickstart:install)



```
帮助信息可参考 `(quicklisp-quickstart:help)`

3. 配置到sbcl启动文件中.sbclrc

```
  ==== quicklisp installed ====

    To load a system, use: (ql:quickload "system-name")

    To find systems, use: (ql:system-apropos "term")

    To load Quicklisp every time you start Lisp, use: (ql:add-to-init-file)

    For more information, see http://www.quicklisp.org/beta/

```

执行`(ql:add-to-init-file)` 会添加如下内容到你的`.sbclrc` 文件中

```
  ;;; The following lines added by ql:add-to-init-file:
  #-quicklisp
  (let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                         (user-homedir-pathname))))
    (when (probe-file quicklisp-init)
      (load quicklisp-init)))

Press Enter to continue.

#P"C:/Users/yzl/.sbclrc"
```


到这里你就可以使用(ql:quickload "包名")来安装lisp软件工具包了,
使用(ql:system-apropos "包名")来查找lisp相关软件工具包。

但是得注意一点，你得把.sbclrc和quicklisp文件夹【当你执行(quicklisp-quickstart:install,其实是在`c:\users\yzl\ 新建了一个quicklisp文件夹，并让以后你通过quicklisp管理的包都放入其中`】，统统拷贝到 `C:\Users\yzl\AppData\Roaming\ `文件夹下

[slime-company][225] : 类似于slime-fancy, 源于这个[issue][226]

#### emacs侧配置

麻痹，真想爆粗口,只支持24和23.4
```
SLIME supports a wide range of operating systems and Lisp implementations. SLIME runs on Unix systems, Mac OSX, and Microsoft Windows. GNU Emacs versions 24 and 23.4 are supported. XEmacs is not supported anymore. 
```

但是也发现[有人在linux搭建成功][227]

setupsbcl.el

```

(setq inferior-lisp-program "~/.emacs.d/customizations/sbcl/sbcl.exe");设置优先使用哪种Common Lisp实现
(add-to-list 'load-path "~/.emacs.d/customizations/slime/");设置Slime路径
(require 'slime)
(slime-setup)
(require 'slime-autoloads)
(slime-setup '(slime-fancy));让slime变得更好看，比如把sbcl的*变成CL-USER>
```

init.el

```
(load "setupsbcl.el");
```

这么不友好！！ 只好温柔的一删，不用slime也可以!只用sbcl+quicklisp
搜一下[lispbox][228]你发现更新到2010 oct,人气不足.

后来发现[陈斌][229]的配置好使, 而且兼容slime,r,python,perldb等，强大啊！

### 102. orgmode 表格说明

```
如何引用表格中其他字段
推荐写法，@row_index$col_index
```

#### 插入公式
在表格中敲击`C-u C-c=`会显示

公式格式=‘@6$2='(算法 空格划分的所有元素)’ ,也就是说`源=list表达式`
比如
```
@6$2='(+ @4$2..@5$2)  4,5两行的第二列求和 
```

```
Field Fomula @2$1=
```
表示当前你所在的表格是第二行 第一列（从1开始）

```

| Date              | Category | Money | People     | Note |   |
|-------------------+----------+-------+------------+------+---|
| <2017-10-30 周一> | 备用     | +3000 | Yezhaolian |      |   |
| <2017-10-30 周一> | 备用     | +7000 | zhujian    |      |   |
| <2017-10-30 周一> | 火车票   | -4000 | zhuijan    |      |   |
|-------------------+----------+-------+------------+------+---|
|                   | Total:   |  6000 |            |      |   |
#+TBLFM: @>$3=vsum(@2..@-1)   

#+REVEAL: split
#+BEGIN_EXAMPLE
    1. @> The @ specifies a row, and this refers to the last row in a table.
    2. $3 The $ specifies a column, so this refers to the third column.
    3. vsum A vertical sum function with parameters given in parenthesis
       vmean 取平均值
    3. @2 The second row. Notice that it the Amount header is @1 and the dashes separating the header from the body is ignored.
    4. @-1 The next to the last row. Using these relative references mean that we can add rows to our table, 
    5. and still have the sum formula work.


http://www.howardism.org/Technical/Emacs/spreadsheet.html
#+END_EXAMPLE


```

org-mode的[The spreadsheet说明][244]

并额外增加了表格模板

```
# -*- mode: snippet; require-final-newline: nil -*-
# name: table2
# key: table2
# --
#+NAME: $1
| Category              | Amount |
|-----------------------+--------|
| $0                      |        |
|-----------------------+--------|
| Total:                |   0.00 |
#+TBLFM: @>\$2=vsum(@2..@-1);%.2f
```

[改进方案][285]

```
   #+TBLFM: @>$3=vmean(@I..@II);::@>$2=vsum(@I..@II);

```

   The syntax =@I..@II= for defining the vertical range between the horizontal rulers is extremely
    useful. One does not need to count the exact row number. Regrettably this syntax can only be
    used on the right side of an equation (So this is forbidden: @I$2..@II$2=5).(I..II是特殊语法，只能用于右边)

  - The use of =>= to indicate the last row or column(最后一行或者最后一列 倒数第二行用-1) is useful, since one does not need to use
    explicit row and column numbers.
  - The number format is controlled by the =%.2f= specifiers at the end of the formulas. The
    syntax is similar to the one used in C format specifiers, e.g. %f for float.


#### 重新计算

光标停留在表格上，`C-u C-c *` 重新计算

或者`C-c C-c`


#### 快速列求和

有一种不需要编写公式就可以对某列求和的方式，将光标定位到某个cell，然后按下C-c + ，就会看到mini buffer的提示，然后按下S-Insert 键，就自动出现了求和的值

```

#+CAPTION: DAU统计  
|   日期 | 新增 | 日活 |   VV |             转化率 |
|--------+------+------+------+--------------------|
|    <6> |      |      |      |                    |
|      / |    < |    > |      |                    |
| 2015-05-01 |   11 |   20 | 42.0 |                2.1 |
| 2015-05-04 |   12 |   20 | 41.0 |               2.05 |
| 2015-05-05 |   22 |   41 | 79.0 | 1.9268292682926829 |
| 2015-05-06 |   47 |   81 | 117. | 1.2098765432098766 |
|    All |   92 |  162 | 155. | 1.6049382716049383 |
#+TBLFM: @4$5='(/ $4 $3);N::@5$5='(/ $4 $3);N::@6$5='(/ $4 $3);N::@7$5='(/ $4 $3);N::@8$2='(+ @4$2..@-1$2);N::@8$3='(+ @4$3..@-1$3);N::@8$4='(+ @4$4..@-1$4);N::@8$5='(/ $4 $3);N  
```

@8$2='(+ @4$2..@-1$2)  这时候@-1表示第七行，@-1叫做last row to @8也就是第七行。右边计算，不加上行信息，表示当前信息


####  显示所有公式【强大】【另类编辑公式】

定位到当前表格中`C-c '` ,显示所有公式[从这里也可以看明白不同的公式之间使用双冒号划分]

在该窗口下使用`C-c C-c` 结束编辑，类似于编辑代码块`C-c s i`

这边得和`C-c \`` 区分开，后者是对当前字段产生一个窗口，进行编辑.

####  美化输出

使用format表达式即可。

```
#+ATTR_HTML: :border 2 :rules all :frame border    
| 计算时长(分钟)       | 原时长 | 改造后时长 | 优化比率(%) |  
|----------------------+--------+------------+-------------|  
| 改造表计算时长总计   | 939.90 |      144.9 |       84.58 |  
| 未改造表总计         |   1311 |       1131 |       13.73 |  
| 未改造周期性提数总计 |     89 |         89 |        0.00 |  
| 总计                 | 2339.9 |     1364.9 |       41.67 |  
#+TBLFM: @5$2='(+ @2$2..@4$2);N::@5$3='(+ @2$3..@4$3);N::$4='(format "%0.2f" (* (/ (* (- $2 $3) 1.0) $2) 100));N 
```

在公式中敲击快捷键`C-c '` 会显示当前表格的所有公式  ;N结尾，没有;N是还有问题的，表达式用list的形式存储，即'()风格。

``` org

# Field and Range Formulas
@4$5 = '(/ $4 $3);N
@5$5 = '(/ $4 $3);N
@6$5 = '(/ $4 $3);N
@7$5 = '(/ $4 $3);N
@8$2 = '(+ @4$2..@-1$2);N
@8$3 = '(+ @4$3..@-1$3);N
@8$4 = '(+ @4$4..@-1$4);N
@8$5 = '(/ $4 $3);N
```

[表格内容对齐][232]



#### 回到开始

有时候你并不能知道具体当前行是第几行第几列，那就`C-c }`就会toggle row index和col_index[<2018-05-02 06:47>] <2018-05-25 11:32>

当然你也可以使用`C-c ?` 显示当前cell的信息

<2018-07-09 22:25>通过`显示`查到
####  新的编辑公式方法

1. 在当前表格中，直接`:=vmean(元素段信息)`
2. `C-c C-c` 即可，把公式添加在表格下面

```
将光标放在（空） [formula] 单元格中, 然后在此字段中输入 :=vmean（$2..$3） 。 该公式意味着：计算此行中第二（ $2 ）到 第三（ $3 ）单元格的字段平均值。 如果喜欢其他符号，请输入 :=vmean(B&..C&) – 其中 & 字符代表在这一行。

在上面键入公式的行中，键入 C-c C-c , 你将观察到两点变化： 1） :=vmean（$2..$3） 已被计算结果代替，2）以 ＃+TBLFM 开头的新行已被插入到表的底部。

＃+TBLFM 行包含表的所有公式，在手动编辑时应小心

链接：https://www.jianshu.com/p/3b184915c8a3
```

注：不用担心使用 M-<left/right> 左右移动列或 M-<up/down> 上下移动行会混淆 ＃+TBLFM 行中的引用，因为每次移动都会自动更新引用。

#### 更强大的插入行功能


一般我们使用`C-c Enter` 表示插入一个表头

`M-enter` 表示在下面插入一个空行,光标下移[<2018-05-03 05:35> 有用！但是对于非空情况下，无法插入<2018-05-25 19:00>]
有一种妥协办法，通过`C-c i`插入一行 ，然后输入|就插入了一行了

`M-S 上下左右箭头`  分表代表增加减小行  增加和减小列

`Tab` 表示调到下一字段， 相反为`S-Tab`

`C-c Space` 清空当前表格(如果是单个单词的话，其实) (先复制到下一行，然后清空当前行 S-ENter  ,C-c Space)

`S-Enter` 将上一行的cell文本复制到下一行[<2018-05-03 04:58>还真感觉挺有用的]


<2018-05-03 20:21> 额外辅助技巧

使用大写的`V` 进入行选模式，[可用于演示时候使用，或者录屏时候]

在evil-mode模式下，一把会创建键盘宏来录制(qa)快速插入`|`竖线的宏， 比如开头，结尾的宏！！**特别有效**，然后使用@a,或者8@a执行8次


#### 为什么使用org-table

[朴素也是一种美][230]！！

```
最后回到本质，org-mode 提倡的宗旨是用简单的列表（plain list) 管理生活的点点滴滴。它注重的是内容本身而不是花哨的外表。用得越多，越觉得，最简单的ASCII也能带来美的感受，美在朴素。
```

#### 如何把excel中数据复制到org-mode做成一张表格？

[excel表格内容直接用于org-mode][231]，其实有命令。操作如下： 
1. 选中所有行； (黏贴的数据)
2. `c-c |` 对应命令的描述如下.(<2018-06-19 23:51> 特别有用，直接黏贴过来表格数据，摁下命令，配合上`C-c Enter`创建表头

表头一般是带有黑色背景，其他都灰色即可，类似于howardism的[database-example][237]


补充，处了;N::结尾，还有;T::结尾的,表示时间相加(还有比如list表达式使用;L)

``` org
If you want to compute time values use the T, t, or U flag, either in Calc formulas or Elisp formulas:

  |  Task 1 |   Task 2 |    Total |
  |---------+----------+----------|
  |    2:12 |     1:47 | 03:59:00 |
  |    2:12 |     1:47 |    03:59 |
  | 3:02:20 | -2:07:00 |     0.92 |
  #+TBLFM: @2$3=$1+$2;T::@3$3=$1+$2;U::@4$3=$1+$2;t
```


``` org
    | expression                | lisp type |
    |---------------------------+-----------|
    | 'mapconcat                | symbol    |
    | #'mapconcat               | symbol    |
    | "text"                    | string    |
    | (concat "hello" " world") | string    |
    | 1                         | integer   |
    | (+ 3 4)                   | integer   |
    | ?a                        | integer   |
    | 1.0                       | float     |
    | '(1 2 3)                  | cons      |
    | [1 2 3 4]                 | vector    |
    | nil                       | symbol    |
    #+TBLFM: @2$2..@>$2='(type-of $1);L
```

#### 命名字段

`!` 放在表头的下一行，表示对当前head的 缩写,相当于定义变量。 如果想要简略计算，需要通过*(表示加入计算)和^(表示不加入计算)来控制哪一行需要计算，这样
可以在计算公式省略行的书写

```org
** 较复杂公式
  |   | Name  | number | cost per item |      sum | incl VAT |
  | ! | name  |    num |       peritem |      sum |          |
  |---+-------+--------+---------------+----------+----------|
  |   | name1 |      3 |       1500.00 |    4500. |  4860.00 |
  |   | name2 |      9 |       4000.00 |   36000. | 38880.00 |
  |   | name3 |      4 |       2800.00 |   11200. | 12096.00 |
  |---+-------+--------+---------------+----------+----------|
  |   | Total |        |               | 51700.00 | 55836.00 |
  #+TBLFM: @>$5..@>$>=vsum(@I..@II);%.2f::@3$5..@5$5=$num * $peritem::@3$6..@5$6=$sum*1.08;%.2f
  
  
 ** 较简略公式 
  |   | Name    | number | cost per item |      sum | incl VAT |
  | ! | name    |    num |       peritem |      sum |          |
  |---+---------+--------+---------------+----------+----------|
  | * | name1   |      3 |       1500.00 |    4500. |  4860.00 |
  | ^ | varname |        |               |          |          |
  | * | name2   |      9 |       4000.00 |   36000. | 38880.00 |
  | * | name3   |      4 |       2800.00 |   11200. | 12096.00 |
  |---+---------+--------+---------------+----------+----------|
  |   | Total   |        |               | 51700.00 | 55836.00 |
  #+TBLFM: @>$5..@>$>=vsum(@I..@II);%.2f::$5=$num * $peritem::$6=$sum*1.08;%.2f

```

![table][286]

### 103. presentation mode

在init.el增加了对所有文件的展示功能，采用[presentation.el][233],`(load presentation.el)`, 可以让你打开的文件处于展示状态，文字放大方便观看，演示

使用方式：`M-x presentation-mode` 进入展示模式，再次`M-x presentation-mode` 退出展示模式
 
 可以使用`C-x C-+`表示放大字体，使用`C-x C--` 来缩小字体


通过这种方式，我们可以自己读读我们写下的电子稿,类似[该作者的想法][234]。


### 104. counsel-org-clock 快速显示正在clock的header

[counsel-org-clock][245], 类似的还有[org-mru-clock][246](mru:most-recently-used),他们两者[有些不同点][247]

使用org-mru-clock打开有一个好处，只打开那个标题下的信息，折叠所有不相关信息(<2018-08-01 17:21>)

what is really the killer feature of counsel-org-clock package is that it can look through your agenda files and 
prefill your clock history with (a given number of) things you actually clocked.

1. supports more Ivy actions[show history, and goto the clocked item]
2. more complete title shown in history list(while org-mru-clock is more simpler with "title(parent)" mode.

`M-x counsel-org-clock-content` 显示所有最近newgtd.org: 
Tasks > TODO [#B] 查阅energy投稿信息 <2018-05-16 周三 17:08 +1w> :学术:标记过clock的标题

有一种工作风格（较为简单）： 如果你之前截止了某一段clock时间，然后想重新开始，直接`M-x org-mru-clock-in` 会跳出一个prompt框，
直接选择其中一个即可。(80%时间是clock-in 并goto的风格)

而如果是`M-x counsel-org-clock-content`(功能比较强大，较为复杂)只是跳转而已,如果需要设置clock，
还得用`M-o`(该命令调用了 `counsel-org-clock-default-action`),然后选择`I`,表示Clock-in。
(20%时间可能会使用q设置标签 p设置属性等，有替换方法比如 C-c C-q  C-c, )

<2018-08-01 09:54>


### 105. what is graphviz?(不错的thinking，think to get，wishful thinking)

[Graphviz][250]的好处在于，你只需要关心数据结构的流程，或者连接的方式，而不需要考虑布局。这是经典的*nix的程序的工作方式，比如latex, mate等等，都是采用这种方式来工作的。既可以达到WYTIWYG（What you think is what you get），而不是微软所提倡的WYSIWYG（What you see is what you get）。

graphviz提供六种绘图的方式:

```
| 布局方式 | 说明                                              |
|----------+---------------------------------------------------|
| dot      | graphviz的默认布局方式，用于画有向图              |
| neato    | spring-model(基于斥力+张力的布局)                 |
| twopi    |                                                   |
| circo    | 在使用过程中，感觉circo算法布局出来的图形最为合理 |
| fdp      |                                                   |
| Sfdp     |                                                   |

```


支持tif, svg, ps, eps等矢量格式输出，以及 jpeg, gif, pdf, bmp等标量输出格式。


#### 两种运用场所

[Graphviz绘图的安装与使用][253]

1. 命令行使用:


```
dot -Tpng sample.dot -o sample.png  
```

详细语法参考 [graphviz-doc][255]。另外，graphviz是如何在python中运用的？  特别不错的[python graphviz的学习教程][254]能够让你看到简单的使用方法。 有空可以看看，如果涉及到大量绘制图形(当然这里重点还是emacs结合graphviz进行literal programming)。

`pip install graphviz `


2. Emacs literal programming运用

``` org

#+BEGIN_SRC dot :file img/.png :cmdline -Kdot -Tpng :exports results :results silent
  digraph G {
    rankdir=LR;
    bgcolor="#ffffff00" # RGBA (with alpha)
    node [shape=box,
          color="gray",    # node border color
          fillcolor=white, # node fill color
          style="filled,solid",
          fontname="Verdana"]
    edge [ penwidth=2, color=white ]

    node [label=""] Base
  }
  #+END_SRC

[[file:img/.png]]

```

另外graphviz也集成到很多编程语言的使用，比如[R][251],[common-lisp with graphviz][252], [python graphviz][254]等

### 106. 不需要密码提交codes到github

1. .gitconfig 文件中添加 

```
[credential]    
    helper = store
```

2. 或者在git bash 中执行

```
git config --global credential.helper store
```

可阅读[git凭证存储][256].

### 107. Poporg注释context下使用org-mode

比如当前的注释语句为;分号开头，想在后面写上一段话，执行`C-c t`
就会弹出一个注释窗口开始编辑，编辑完`C-c t`, 就会对你刚才写的
这段话进行注释。

.orgConf.el的配置：

``` org

(use-package poporg
      :bind (("C-c t" . poporg-dwim)))
```

如果不是在代码注释快，敲`C-c t`,会提示`Nothing to edit`.

想起她来了!<2018-06-26 20:27>

### 108. emacs mode(伟大的question mark?)

emacs是没有模块的概念，只有mode概念，常用的是

1. [define-major-mode][262]
2. [define-minor-mode][263]

并且可以设置[File to Open in a Major Mode][260]


而这里面最想说的一点是，如果你不知道当前mode有哪些快捷键，尝试摁一下 `question mark: ?`

当然有人可能说
`(info "(emacs)Choosing Modes")`

Some advice from howardisms: [Advice to Code Reviewers][261]
#### What is sensei?

    Perhaps we should change the term from mentor to sensei, as one definition of that term I’ve heard is: 
    one who is further ahead on the path; which characterizes a teacher as one who can look back along a 
    path and say,:" 
        Watch your step there, that’s a particularly slippery spot. If you do fall, it’s okay, 
        because I fell too."
    It’s a compassionate approach to teaching, which we should all adopt.     
    
----------


#### Bread and Butter
        
     Time for a story. Every time I run the linter on my Python code, 
     it complains bitterly about my use of     map, filter and reduce, 
     and claims I should use a comprehension. 
     Perhaps this may date me, 
         but these functions are my bread and butter, as they seem so clear to me. 
     Comprehensions, on the other hand, seem verbose and clutter intention. However, 
     I usually rewrite them as my other colleagues agree with the linter and feel it is easier to read. 

----------

#### Listen to subjection ,maybe you are wrong


    You can be wrong too. Obviously, not all the time, but you can never be too sure. 
    Don’t take this advice as an urge to limit your comments, but in the conversation that occurs, 
    recognize your teammates perspective is valid tool.

----------

#### We do not you do


Also substitute we for you, as in:(you)

    Add a comment to the complex algorithm you wrote.

To something like:(we)

    With such a complex algorithm, we should add a clarifying comment.
    
Granted, we could apply all these tips, to really begin a discussion:

    With such an innovative approach to solving this problem, should we add a clarifying comment explaining it, 
    or 
    should we break out some of the expressions into functions that we could name to help the reader follow the logical flow?

### 108. 解锁折叠世界

知识、见识、眼界随着人的阅历、家庭背景而千差万别。真实的世界无疑是存在折叠的世界，都有各种各样的活法，所以才有说法:"参差多态才是幸福的本源"

于是， 惯于无常，自是庆幸，知其无可奈何，仍安之若命。

               逝者如斯夫

```
        莫   但    果    因
        问   行    上    上
        前   善    随    努
        程   事    缘    力
```

要注意表里如一。

[如何理解果上随缘][265]

```
　　果上随缘是对待事件结果的一种心态，也是修行者需要持有的心态。所有在因上努力后，
如果能得到圆满的结果自然是可喜，但是世上事，总不能永远顺人意，这就需要一种坦然的心态。
所求圆满，需要福德、智慧的成就，有时候福报、德行不足，硬是让所求圆满，不仅不见得是好事，
或许还会有损害。再者，凡夫智慧有限，世俗财色名利的圆满，并不见得会是对生命质量的补助，
缺一点还能更加的提升自己，不至于落于自满自足状态而徒生堕落。进一步说，过多的圆满，会导
致更多的贪欲，欲求不满，亦会导致更为强盛的烦恼。因此，对待果的成就，需要随缘的姿态，
也就是佛教所说的"放下"。

　　[放下]并不是不管不顾，也不是懈怠的借口，放下应该是一种努力过后的豁达。所谓尽人事听
天命，不拘泥于结果的好坏，只注重过程的精进与否。没有去努力，怎么谈放下;更实际的说，没有
得到，怎么去放下。佛法中的放下，不应当是自暴自弃、不管不顾、不负责任的丢弃不顾，而是在得
到后，或者是在努力后对结果的一种淡然态度。更精确的应该是面对世间事物的洒脱，高空中白云悠
悠的自在，这种自在是需要立足于空广蓝天，需要一定的心灵高度。
```

![cause][264]


```
    两位朋友聊天，一位朋友因为技术社群中一个人的言行而非常愤怒、感觉自己受到了诽谤。另一朋友劝他（此人从僧人处学到的）

         :"别人给你送来的恶意，就相当于别人送你的礼物，
           你不收下、不放在心上，恶意就会返回到
           送礼者手中，如果你收下了，就会让自己烦恼。"
         
    另一朋友以前也是一个性情中人，常常因为别人的言行影响他的情绪，现在则平和很多，碰到网上偶尔对他口出狂言的他都
    把它删了、拉黑就行了，根本不会内心有任何的波澜。放下执着！人这辈子，学会做人就不白活。

```

```
    ----------


         《青松》
           陈毅
    大雪压青松，轻松挺且直。
    要知松高洁，待到雪化时。
    ----------

    
    叶剑英：
      成则为周武三千，败则为田横五百，可常可变，可生可死. 
      
      自古英雄多出自草莽，大丈夫何患乎文凭！【努力即可】
      
      攻城不怕坚，攻书莫畏难。科学有险阻，苦战能过关。
      
      毛借吕端评价叶帅在革命期间力挽狂澜，四两拨千斤的能力，关键时刻不糊涂，明断是非，果断抉择
      ："诸葛一生唯谨慎，吕端大事不糊涂。"(三分天下诸葛亮，一统江山刘伯温）
      
      跳出三维的世界，感受历史、现在和未来的时空维度，历史总是惊人的相似，昨日发生的事情，今日又将重现。
     ----------

 
             周恩来送给耿彪三句话

    别人要打你，无论别人怎么打你，你自己不要倒
    别人要赶你，无论别人怎么赶你，你自己不要走
    别人要整你，无论别人怎么整你，你自己不要死。
    ----------

    毛泽东赠送给彭德怀 :"山高路险沟深，骑兵任你纵横。谁敢横枪勒马，唯我彭大将军"
    
   ----------

----------

   邓小平："这是登山时候最疲累的时候，脚步可以慢下来，但是不能停下来。"
 
```

[刘伯温][304]

[生产力？][305]

生产力就三个字，叫我愿意。我愿意，我的生产力就高；我不愿意，我的生产力就低。当你愿意做的时候，你不会计较太多，多少钱都没关系，辛苦点怕什么，我有事情做就已经很享受了嘛！可是当你不愿意的时候，你就会找一千个、一万个理由去推脱，这是肯定的。所以人要记住，不要靠别人来激励你，而是要靠自己来激励自己，这才是高明的人。求人不如求己。

### 109. 伟大的awk and rename(story programming)

<2018-06-02 17:03> 我很喜欢awk编程语言,开头，中间，结尾的故事编程方法。


有时候写文章需要把大量的图片重命名，比如Fig.18到Fig20. 

下面的代码就是根据Fig21该为Fig22, Fig20改为Fig21的过程

#### Rename 例子


```
#+BEGIN_SRC awk :dir c://Figures

 for i in `seq 21 -1 12`; do rename $i $(($i+1)) *;done

#+END_SRC


# awk star definition

 cat filename.csv|awk -F, 'BEGIN{prefix="sphere12-14-15-1-";postfix=".dat"}{output=prefix""substr($1,0,length($1)-1)""postfix;input=$2""postfix;cmd="rename "input" "output" "input;system(cmd)}'
 
 # -1 because the space
 
 # -4 because tab spend 4 space
 ls *.dat|awk -F"-" 'BEGIN{T=0.834493; dt=T/72.0; i=1; ta=10.0139; }{a=substr($5,0,length($5)-4); ct=ta+dt*(i-1);print
 a,",",(ct/T-int(ct/T))*360,",",ct; i++;}'


# awk reverse sort number
cat filename.csv|awk -F, '{print $2|"sort -rn"}'

# sort -k2 -n 可以针对数字的第二个默认delimeter[默认是空格]划分的字段进行排序【且是整行进行】, -t指定分割符
# 特别强大的是-n改变为 -g就可以比较自然计数比如 1.0E0  1.0E1  1.01E0 如果用-n比较则1.0E1会排在1.01E0之前
# 而如果改为-g则会按照数值的真正大小进行比较




# seq reverse show numbers
seq 216 -1 1
```

rename语法

`rename 要匹配的表达式 新的表达式 文件名`,如果文件名为星号，代表当前文件夹下
的所有文件。


#### AWK 例子


提取每个文件的时间信息，然后做前后加减

```
#+BEGIN_SRC awk :dir M://fluentYaw30

  ls *.cas|awk -F"-"  '{print a[NR]=substr($5,0,length($5)-8);}END{for(i=1;i<=NR-1;i++) print a[i+1]-a[i];}
                                                              '

#+END_SRC

```

AWK用于翼型坐标点导致，注意awk中小括号组合代表函数调用，而中括号代表数组。

```
$ cat test1|awk '{a[NR]=$1;b[NR]=$2;c[NR]=$3;} END{for(i=length(a);i>0;i--) print a[i],b[i],c[i]}'


```

[awk基础排序][301]
END中 asort对数组a的值进行排序，把排序后的下标存入新生成的数组b中，丢弃数组a下标值(asort之后丢弃原先数组)，再把数组a的长度赋值给变量slen(而asorti不会丢弃原先数组)

[awk多字段排序][302]

[sort 多字段排序][303] 
`sort -k 2 -k 3` 先按第二个域排列，第二个域相同再按照第三个域排列

运用1：

``` awk
yzl@DESKTOP-MVNHR6D /cygdrive/c/Users/yzl/Desktop/fangqiang
$ cat export1wan2.csv|awk '{if(NR>6){print $0}}'|sort -g -t, -k 3 -k 4 >hello3.csv

```

进一步运用(同时进行排列)
``` awk

cat export1wan2.csv|awk '{if(NR>6){print $0}}'|sort -g -t, -k 3 -k 4| awk -F, 'BEGIN{xNum=100;yNum=100;count=1;}{a[count]=$1;b[count]=$2;count=count+1} END{for(i=1;i<=xNum;i++){for(j=1;j<=yNum;j++){printf("%f",a[j+(i-1)*xNum]); };print "" }}'
```

``` awk
# 此时$1"|"$4变成了一个字段名，这是比较特别的地方
awk '{a[$1"|"$4]=$0;b[$1];c[$4]}END{
	for(i=1;i<=asorti(b,bb);i++)
		for(j=asorti(c,cc);j>=1;j--)
			if(bb[i]"|"cc[j] in a)
				print a[bb[i]"|"cc[j]]
	}' file
```

### 110. 伟大的find

有时候用ls显示文件，准备删除，但是未出现一些显示颜色出现的问题，比如

```
$ ls -ls |grep '(1).jpg'|awk '{print $10|"xargs rm"}'
rm: 无法删除''$'\033''[01;32mIMG_20180420_194438(1).jpg'$'\033''[0m': No such file or directory
rm: 无法删除''$'\033''[01;32mIMG_20180420_194624(1).jpg'$'\033''[0m': No such file or directory

```

可以看出来问题在于ls显示文件时候，带上了颜色。 在这种前提下,使用下面各种方法都没有好的效果【方向错误，怎么做都没用】

```
1.   for i in `ls .*|grep '(1).jpg'`; do rm -r $i;done
2.   ls .*|grep '(1).jpg'|xargs rm -rf
 

```


于是想着使用伟大的find命令,成功解决了我的需求。


```
find . -type f|grep '(1).jpg'|xargs rm -rf

```


一些额外有用的命令

```
----------


f 普通文件
l 符号连接
d 目录
c 字符设备
b 块设备
s 套接字
p Fifo
----------



1. 找到大于100M以上的文件:
    find . -type f -size +100M
2. 查找当前目录或者子目录下所有.txt文件，但是跳过子目录sk
    find . -path "./sk" -prune -o -name "*.txt" -print
3. 搜索超过七天内被访问过的所有文件
    find . -type f -atime +7
    还有amin +10 超过10min
    UNIX/Linux文件系统每个文件都有三种时间戳：
        1. 访问时间（-atime/天，-amin/分钟）：用户最近一次访问时间。
        2. 修改时间（-mtime/天，-mmin/分钟）：文件最后一次修改时间。
        3. 变化时间（-ctime/天，-cmin/分钟）：文件数据元（例如权限等）最后一次修改时间。
4. 找出比file.log修改时间更长的所有文件
    find . -type f -newer file.log
5. 基于正则表达式匹配文件路径
    find . -regex ".*\(\.txt\|\.pdf\)$"
6. 同上，但忽略大小写
    find . -iregex ".*\(\.txt\|\.pdf\)$"
7. !的使用
   find   /mnt   -name t.txt ! -ftype vfat   在/mnt下查找名称为tom.txt且文件系统类型不为vfat的文件
   find /home ! -name "*.txt"   找出/home下不是以.txt结尾的文件
   
----------

高级命令

1. find . -type f -exec ls -l {} \;   
find logs -type f -mtime +5 -exec   -ok   rm {} \;
find   ./   -mtime   -1   -type f   -ok   ls -l   {} \;  

```

### 111. write good mode for writes


在翻阅[planet on emacs][266],看到关于写作方面建议的好文章，

于是试试[writegood Mode][267],会把夸张的词语勾出来，画个波浪线。


``` org

* Weasel words
Weasel words--phrases or words that sound good without conveying information--obscure precision.

I notice three kinds of weasel words in my students' writing: (1) salt and pepper words, (2) beholder words and (3) lazy words. 
** Salt and pepper words
New grad students sprinkle in salt and pepper words for seasoning. These words look and feel like technical words, but convey nothing.

My favorite salt and pepper words/phrases are various, a number of, fairly, and quite. Sentences that cut these words out become stronger.


#+BEGIN_SRC org
    Bad:    It is quite difficult to find untainted samples.
    Better: It is difficult to find untainted samples.
    Bad:    We used various methods to isolate four samples.
    Better: We isolated four samples.
#+END_SRC

** Beholder words
Beholder words are those whose meaning is a function of the reader; for example: interestingly, surprisingly, remarkably, or clearly.

Peer reviewers don't like judgments drawn for them.


#+BEGIN_SRC org
  Bad:    False positives were surprisingly low.
  Better: To our surprise, false positives were low.
  Good:   To our surprise, false positives were low (3%).

#+END_SRC

** Lazy words
Students insert lazy words in order to avoid making a quantitative characterization. They give the impression that the author has not yet conducted said characterization.

These words make the science feel unfirm and unfinished.

The two worst offenders in this category are the words very and extremely. These two adverbs are never excusable in technical writing. Never.

Other offenders include several, exceedingly, many, most, few, vast.


#+BEGIN_SRC org
   Bad:    There is very close match between the two semantics.
   Better: There is a close match between the two semantics.

#+END_SRC

** Adverbs
In technical writing, adverbs tend to come off as weasel words.

I'd even go so far as to say that the removal of all adverbs from any technical writing would be a net positive for my newest graduate students. (That is, new graduate students weaken a sentence when they insert adverbs more frequently than they strengthen it.)


#+BEGIN_SRC org
   Bad:    We offer a completely different formulation of CFA.
   Better: We offer a different formulation of CFA.
#+END_SRC

```

然后可以开启`M-x writegood mode`并配合上`M-x writegood-grade-level`

如果特别好，writegood-grade-level会提示得分无穷大，如果很差则分数很低。


关于[英文写作的建议][268]

### 112. Writer room mode

`M-x writeroom-mode` 的效果会把状态栏给关闭(disable the mode line)，而只是留下一个编辑窗口和一条线，区分编辑栏和命令栏，效果满意，所以保留。


``` org
writeroom-mode is a minor mode for Emacs that implements a distraction-free writing mode similar
to the famous Writeroom editor for OS X. writeroom-mode is meant for GNU Emacs 24, lower versions
are not actively supported.

```

### 113. Dashboard your life

#### dashboard.el

using: good for managing the recent used files and agenda.

[dashboard.el][272] is a start screen for EMACS, which is similar to the [vim-startup][274]


Note:
     Unload the setup-dashboard.el setting in the start-up due to the heavy loading of the config for
     the dashboard.

----------

#### org-dashboard.el

Using: good for visualize the header1 with CATEGORY properties

   org-dashboard的项目给你一个idea，每个工作都是你自己的项目，项目分为很多子项目，并且通过checkbox来控制进度，统一通过
org-dashboard来监控进度<2018-06-20 11:44>。
   org-dashboard回去查找最大标题下的:CATEGORY:属性，如果没有设置，默认使用标题来表示。
[org-dashbard.el][273]

Take care

1. Header1
2. CATEGORY:

``` org
* Project: Better Health
:PROPERTIES:
:CATEGORY: health
:END:

** Milestones
*** [66%] run 10 km/week
**** TODO learn proper warmup
**** DONE look for a jogging partner
**** DONE run 10 minutes on monday

* Project: Super Widget
:PROPERTIES:
:CATEGORY: widget
:END:

** Milestones
*** [1/6] release 0.1
**** DONE git import
**** TODO create github project
**** TODO add readme
**** TODO publish
```


配置

``` org
;; org-dashboard

(setq org-dashboard-files (list 
                           "~/.emacs.d/GTD/orgBoss/newgtd.org"
                           "~/.emacs.d/GTD/orgBoss/hello.org"
))

;For example, to avoid displaying entries that are finished (progress = 100), not started (progress = 0), or are tagged with "archive", use the following:


(defun my/org-dashboard-filter (entry)                     ;;
    (and (> (plist-get entry :progress-percent) 0)         ;;
        (< (plist-get entry :progress-percent) 100)        ;;
        (not (member "archive" (plist-get entry :tags))))) ;;
                                                           ;;
(setq org-dashboard-filter 'my/org-dashboard-filter)       ;;


```

usage: `M-x org-dashboard-display`

![org-dash][275]


org-dash的原理是通过读取标题里的任务量或者比重，通过org-dashboard-filter确认哪些不需要显示，而不关心是不是todo标签是完成还是未完成。因为有时候即使进度未完成也可能设置为任务完成【不想做了】

也就是这边的org-dash会处理两种类型的信息

都是基于标题的[/]或者[%]来进行可视化,分为以下两种形式：

1. header 带todo done等标签的, todo表示未完成(添加todo tag) done表示完成(添加done tag)
2. header 下方带checkbox的list（header本身不能带checkbox）, checked表示已完成(C-c C-c),Alt+shift+enter添加新的unchecked box


### 114. Copy codes into code-snippets.org file


####  functions for copy codes

``` org

;; http://ul.io/nb/2018/04/30/better-code-snippets-with-org-capture/ 
(defun my/org-capture-get-src-block-string (major-mode)
  "Given a major mode symbol, return the associated org-src block
string that will enable syntax highlighting for that language

E.g. tuareg-mode will return 'ocaml', python-mode 'python', etc..."

  (let ((mm (intern (replace-regexp-in-string "-mode" "" (format "%s" major-mode)))))
    (or (car (rassoc mm org-src-lang-modes)) (format "%s" mm))))


(defun my/org-capture-code-snippet (f)
  (with-current-buffer (find-buffer-visiting f)
    (let ((code-snippet (buffer-substring-no-properties (mark) (- (point) 1)))
          (func-name (which-function))
          (file-name (buffer-file-name))
          (line-number (line-number-at-pos (region-beginning)))
          (org-src-mode (my/org-capture-get-src-block-string major-mode)))
      (format
       "file:%s::%s
In ~%s~:
#+BEGIN_SRC %s
%s
#+END_SRC"
       file-name
       line-number
       func-name
       org-src-mode
    code-snippet))))
    
    
(defun my/org-dir-file (name)
    "Prepend name with path to the org-directory root"
    (concat org-directory name))
```

必须得使用`M-x which-function-mode` 才可以进行code snippet捕捉, 否则提示`(void-function which-function)`--->A bug!

####  Template design for org-capture

vim中使用书签进行[临时代码收藏][299] 大写字母可以是跨文件调用，小写字母
只能是当前文件夹的存储。


``` org
            
("c" "code snippet" entry (file "~/.emacs.d/GTD/orgBoss/code-snippets.org")
"* %?\n%(my/org-capture-code-snippet \"%F\")")        
```

####  Result


It is very good to capture the codes with the format below:(maybe you should open the which function mode, to
let you use the which-function.

```org
* comment 
file:k:/clojure-home/clj-new-github/src/clj_new_github/core.clj::17
In ~foo~:
#+BEGIN_SRC clojure

(comment
  (+ 1 2 3 4)
  (let [url "https://api.github.com/repos/rails/rails/stats/contributors"]
    (type (http/get url))))
#+END_SRC

```

### 115. Page break lines

[page break line][276]

how to input page break line, `Ctrl-q Ctrl-L`, 可以分页行为，copy到word文档就是分页符了
<2018-06-30 15:10> 在Emacs帮助文档经常出现！

[emacs line ending][277]


### 116.  org-listcruncher


  [org-listcruncher][278] provides a way to convert org-mode lists into
  a table structure following specific semantics.
  
  关于文学编程参考：
  
  1. [howardism literate-devops][76]
  2. [library-of-Babel][279]
  3. [Reproducible Research and Software Development Methods for Management tasks][280]
  4. [Org-babel-reference card][281]
  
  目的：
  1. Tasks under automation and integration(still a long way to go<2018-05-25 11:11>)
  2. concept(motivation and explanation), data, code into one file.
  
#### 测试源数据


``` org
   #+NAME: lsttest
   - item: First item (kCHF: 15, recurrence: 1, until: 2020)
     - modification of the first item (kCHF: 20)
     - another modification of the first item (other: 500)
       - modification of the modification (other: 299)
   - item: second item (kCHF: 50, recurrence: 4)
   - category (recurrence: 5)
     - item: a category item A (kCHF: 10)
     - item: a category item B (kCHF: 20)
     - item: a category item C (kCHF: 30)
       - a modification to category item C (kCHF: 25, recurrence: 3)
```
----------

#### 解析规则
   The rules for writing such a planning list are
   1. Each line contains a tag defining wheter the line will become a table row. For this
      example I defined this as the string "item:". Rows without such a tag just serve as
      metadata.
   2. A string following the output tag "item:" is taken as the description of the table row.
   3. Each line can contain any number of key/value pairs in parentheses in the form
       =(key1: val1, key2: val2, ...)=
   4. Lines of lower hierarchical order in the list inherit their default settings for key/values
      from the upper items.
   5. The key value of a higher order item can be overwritten by a new new value for the same key
      in a lower order line.(类似于todo tag的继承关系)
----------
也就是说把相同部分放在上层，下层主要注明不同的地方即可！金字塔思路！

原理示意：

上面的解析过程结果如下, 通过`org-listcruncher--parselist`函数把字符串进行解析

``` org
   #+BEGIN_SRC elisp :results output :var lname="lsttest"
     (pp (org-listcruncher--parselist (save-excursion
				       (goto-char (point-min))
				       (unless (search-forward-regexp (concat  "^ *#\\\+NAME: .*" lname) nil t)
					 (error "No list of this name found: %s" lname))
				       (forward-line 1)
				       (org-list-to-lisp))
				     nil
				     nil))
   #+END_SRC

   #+RESULTS:
   #+begin_example
   ((("kCHF" "25")
     ("recurrence" "3")
     ("kCHF" "30")
    ("kCHF" "20")
     ("kCHF" "10")
     ("recurrence" "5")
     ("kCHF" "50")
     ("recurrence" "4")
     ("other" "299")
     ("other" "500")
     ("kCHF" "20")
     ("kCHF" "15")
     ("recurrence" "1")
     ("until" "2020"))
    ((("description" "First item ")
      ("other" "299")
      ("other" "500")
      ("kCHF" "20")
      ("kCHF" "15")
      ("recurrence" "1")
      ("until" "2020"))
     (("description" "a category item A ")
      ("kCHF" "10")
      ("recurrence" "5")
      ("kCHF" "50")
      ("recurrence" "4"))
     (("description" "a category item B ")
      ("kCHF" "20")
      ("recurrence" "5")
      ("kCHF" "50")
      ("recurrence" "4"))
     (("description" "a category item C ")
      ("kCHF" "25")
      ("recurrence" "3")
      ("kCHF" "30")
      ("recurrence" "5")
      ("kCHF" "50")
      ("recurrence" "4"))
     (("description" "second item ")
      ("kCHF" "25")
      ("recurrence" "3")
      ("kCHF" "30")
      ("kCHF" "20")
      ("kCHF" "10")
      ("recurrence" "5")
      ("kCHF" "50")
      ("recurrence" "4"))))
   #+end_example


```


#### 例子


   Now we can use org-listcruncher to convert this list into a table   
``` org
   #+NAME: src-example1
   #+BEGIN_SRC elisp :results value :var lname="lsttest" :exports both
     (org-listcruncher-to-table lname)
   #+END_SRC

   #+RESULTS: src-example1
   | description       | other | kCHF | recurrence | until |
   |-------------------+-------+------+------------+-------|
   | First item        |   299 |   20 |          1 |  2020 |
   | second item       |       |   50 |          4 |       |
   | a category item A |       |   10 |          5 |       |
   | a category item B |       |   20 |          5 |       |
   | a category item C |       |   25 |          3 |       |

```
----------


   We can also provide an additional argument to affect the order in which the table is rendered.
``` org
   #+BEGIN_SRC elisp :results value :var lname="lsttest" :exports both
     (org-listcruncher-to-table lname '("description" "kCHF" "recurrence"))
   #+END_SRC


``` org
   #+RESULTS:
   | description       | kCHF | recurrence | other | until |
   |-------------------+------+------------+-------+-------|
   | First item        |   20 |          1 |   299 |  2020 |
   | second item       |   50 |          4 |       |       |
   | a category item A |   10 |          5 |       |       |
   | a category item B |   20 |          5 |       |       |
   | a category item C |   25 |          3 |       |       |

```

有意思的是，可以直接对表格`C-c '` 进行公式编辑， 按照[102.org-mode表格说明][282]
<2018-07-09 22:15> 重新学了一遍!
当定位到某个表格cell，该区域自动高亮。

####  配置snippet

``` org

# -*- mode: snippet -*-
# name: list-cruncher
# key: lstcc
# --
#+NAME: lsttest
- item: $0
    - $1 
    - $2 
    - $3 
- item: $4 
    - category (recurrence: 5)
    - item: $5 a category item C (kCHF: 30)

#+NAME: src-example1
#+BEGIN_SRC elisp :results value :var lname="lsttest" :exports both
(org-listcruncher-to-table lname)
#+END_SRC

```

#### lobPostAlignTables的用法(结合python)

有些时候可能需要对结果进行进行重新格式化，并使用中间语言进行后处理，于是可以用[lobPostAlignTables][283]进行美化。

####  函数定义

 定义lobPostAlignTables在org文档内,

``` org
   #+NAME: lobPostAlignTables
   #+header: :var text="|5|22222|\n|0||\n|12|45|\n|---\n|||\n#+TBLFM:@>$1=vsum(@1..@-1)\n\n|1|22222|\n|0||\n|12|45|\n"
   #+BEGIN_SRC emacs-lisp :results value :exports both
     (with-temp-buffer
       (erase-buffer)
       (cl-assert text nil "PostAlignTables received nil instead of text ")
       (insert text)
       (beginning-of-buffer)
       (org-mode)
       (while
           (search-forward-regexp org-table-any-line-regexp nil t)
         (org-table-align)
         (org-table-recalculate 'iterate) (goto-char (org-table-end))) (buffer-string)) #+END_SRC #+RESULTS: lobPostAlignTables #+begin_example |  5 | 22222 | |  0 |       | | 12 |    45 | |----+-------| | 17 |       | ,#+TBLFM:@>$1=vsum(@1..@-1) |  1 | 22222 | |  0 |       | | 12 |    45 | #+end_example


```

#### 使用lobPostAlignTables

在代码段头部增加一个:post字段

``` org
    #+HEADER: :var tbl=srcTable
   #+BEGIN_SRC python :results output raw drawer :colnames no :post lobPostAlignTables(*this*) :exports both
     import orgbabelhelper as obh
     import pandas as pd

     df = obh.orgtable_to_dataframe(tbl, index="descr")
     df["Terces"] = pd.to_numeric(df["Terces"])
     dfgrp = df.groupby(["service", "account"], as_index=False).sum()
     dfgrp = dfgrp[["service", "account", "Terces"]]
     print(obh.dataframe_to_orgtable(dfgrp, index=False, caption="Service costs and funding",
				     name="tblGrouped"))
   #+END_SRC 

   #+RESULTS:
   :RESULTS:
   #+CAPTION: Service costs and funding
   #+NAME: tblGrouped
   | service       | account       | Terces |
   |---------------+---------------+--------|
   | SvcRestaurant | Captain Bount |     60 |
   | SvcRestaurant | Soldinck      |    186 |
   | SvcWorminger  | Drofo         |     30 |
   | SvcWorminger  | Mercantides   |    430 |

   :END:


```


#### 功率计算

#####  方式1

``` org
#+NAME: lsttest
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:0,扭矩(N):780.4395,功率(kw):0)
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:5,扭矩(N):772.4518775,功率(kw):0)
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:10,扭矩(N):751.9982623,功率(kw):0)
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:15,扭矩(N):717.1466236,功率(kw):0)
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:20,扭矩(N):664.4137199,功率(kw):0)
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:25,扭矩(N):613.0588342,功率(kw):0)
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:30,扭矩(N):548.0095763,功率(kw):0)
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:45,扭矩(N):321.5275501,功率(kw):0)
 - item: PhaseVI风力机(转速(rpm):71.9,风速(m/s):7,偏航角:60,扭矩(N):100.0106446,功率(kw):0)
 - item: NREL5MW风力机 (转速(rpm):11.4,风速(m/s):12.1,扭矩(N):4329000,功率(kw):0)

#+NAME: src-example1
#+BEGIN_SRC elisp :results value :var lname="lsttest" :exports both
  (org-listcruncher-to-table lname)
  #+END_SRC

  #+RESULTS: src-example1
  | description   | 偏航角 |     扭矩(N) | 功率(kw) | 转速(rpm) | 风速(m/s) |
  |---------------+--------+-------------+----------+-----------+-----------|
  | case1         |      0 |    780.4395 |        0 |      71.9 |         7 |
  | case2         |      5 | 772.4518775 |        0 |      71.9 |         7 |
  | case3         |     10 | 751.9982623 |        0 |      71.9 |         7 |
  | case4         |     15 | 717.1466236 |        0 |      71.9 |         7 |
  | case5         |     20 | 664.4137199 |        0 |      71.9 |         7 |
  | case6         |     25 | 613.0588342 |        0 |      71.9 |         7 |
  | case7         |     30 | 548.0095763 |        0 |      71.9 |         7 |
  | case8         |     45 | 321.5275501 |        0 |      71.9 |         7 |
  | case9         |     60 | 100.0106446 |        0 |      71.9 |         7 |
  | PhaseVI风力机 |     60 | 100.0106446 |        0 |      71.9 |         7 |
  | NREL5MW风力机 |        |     4329000 |        0 |      11.4 |      12.1 |
  #+TBLFM: @2$6..@>$6=$5*$2*2*3.1415926/60/1000

```

##### 方式2 


``` org

#+NAME: lsttest2
 - item: 阶段1(转速(rpm):71.9,风速(m/s):7,风力机:Nrel PhaseVI)
   - item: case1 (偏航角:0,扭矩(N):780.4395,功率(kw):0)
   - item: case2 (偏航角:5,扭矩(N):772.4518775,功率(kw):0)
   - item: case3 (偏航角:10,扭矩(N):751.9982623,功率(kw):0)
   - item: case4 (偏航角:15,扭矩(N):717.1466236,功率(kw):0)
   - item: case5 (偏航角:20,扭矩(N):664.4137199,功率(kw):0)
   - item: case6 (偏航角:25,扭矩(N):613.0588342,功率(kw):0)
   - item: case7 (偏航角:30,扭矩(N):548.0095763,功率(kw):0)
   - item: case8 (偏航角:45,扭矩(N):321.5275501,功率(kw):0)
   - item: case9 (偏航角:60,扭矩(N):100.0106446,功率(kw):0)
 - item: 阶段2 (转速(rpm):11.4,风速(m/s):12.1,扭矩(N):4329000,功率(kw):0,风力机:NREL 5MW)

#+NAME: src-example2
#+BEGIN_SRC elisp :results value :var lname="lsttest2" :exports both
  (org-listcruncher-to-table lname)
  #+END_SRC

  #+RESULTS: src-example2
  | description | 偏航角 |     扭矩(N) |   功率(kw) | 转速(rpm) | 风速(m/s) | 风力机       |
  |-------------+--------+-------------+------------+-----------+-----------+--------------|
  | case1       |      0 |    780.4395 |  5.8762024 |      71.9 |         7 | Nrel PhaseVI |
  | case2       |      5 | 772.4518775 |  5.8160607 |      71.9 |         7 | Nrel PhaseVI |
  | case3       |     10 | 751.9982623 |  5.6620583 |      71.9 |         7 | Nrel PhaseVI |
  | case4       |     15 | 717.1466236 |  5.3996481 |      71.9 |         7 | Nrel PhaseVI |
  | case5       |     20 | 664.4137199 |  5.0026036 |      71.9 |         7 | Nrel PhaseVI |
  | case6       |     25 | 613.0588342 |  4.6159347 |      71.9 |         7 | Nrel PhaseVI |
  | case7       |     30 | 548.0095763 |  4.1261560 |      71.9 |         7 | Nrel PhaseVI |
  | case8       |     45 | 321.5275501 |  2.4208935 |      71.9 |         7 | Nrel PhaseVI |
  | case9       |     60 | 100.0106446 | 0.75301517 |      71.9 |         7 | Nrel PhaseVI |
  | 阶段1       |     60 | 100.0106446 | 0.75301517 |      71.9 |         7 | Nrel PhaseVI |
  | 阶段2       |        |     4329000 |  5167.9827 |      11.4 |      12.1 | NREL 5MW     |
  #+TBLFM: @2$4..@>$4=$5*$3*2*3.1415926/60/1000

```

### 117. 有趣的org-babel calc

首先得在.orgconf.el中加载calc语言

``` org
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (sh . t)
   (python . t)
   (R . t)
   (calc . t)
   (ruby . t)
   (ditaa . t)
   (dot . t)
   (octave . t)
   (sqlite . t)
   (perl . t)
   (C . t)
   ))



```

然后才能正常使用calc代码块,把下面代码保存为org文件，`C-c C-c`(twice ctrl c)其乐无穷。

``` org
  #+BEGIN_SRC calc
24
4
'/
  #+END_SRC

  #+RESULTS:
  : 6


  - solving an equation
    #+BEGIN_SRC calc :exports both
fsolve(x*2+x=4,x)
#+END_SRC

    #+RESULTS:
    : x = 1.33333333333

  
  - solving a linear system of equations（一元二次方程）
    #+BEGIN_SRC calc
  fsolve([x + y = a, x - y = b],[x,y])
    #+END_SRC

    #+RESULTS:
    : [x = a + (b - a) / 2, y = (a - b) / 2]


```


更进一步参考[dfeich calc.org][284]


#### 如何把自定义的babel系列函数放入org-babel加载库中?

With the help of [The Library of Babel][288], we don't have to include [the code block][287] get-named-text into every Org file. 
I put the block into an Org file under my .emacs.d directory, $HOME/.emacs.d/custimazations/org-babel-lib.org. 
Then put this line into my .orgConf.el:


``` org
(org-babel-lob-ingest (expand-file-name "~/.emacs.d/custimizations/org-babel-lib.org"))
```

This makes the code block get-named-text a predefined and callable code block that can be seen and called in any Org file.

####  Ob-async异步执行

保证代码执行过程继续使用emacs

Code execution in Emacs is synchronous by default, meaning that you will be locked out of editing while the code is being run.
    Fortunately, the fantastic ob-async package allows for asynchronous code execution with the :async arg,
meaning that you can still use Emacs while the code snippet is run in the backgroundThere are some small 
things you give up by using the ob-async package.
    In particular, the :session functionality is absent in general, which otherwise allows variables and function definitions to persist across blocks of code. . Once the package is installed, simply include :async t to the source code block and run it again:

``` org
#+BEGIN_SRC bash :dir /user@127.0.0.1: :async t
  pwd
  echo $USER
  hostname -I
#+END_SRC

#+RESULTS:
: 0ddf0124c8fcb26d53fdba83dc4773f6
```

### 118. org-sidebar

类似于[org-listcrunch][278], [org-sidebar][289]也处于刚刚起步阶段，所以可能还有bug，但效果还不错，于是把它添加进来。

`M-x package-install dash-functional`也得安装。

对我没用，所以从init.el剔除掉！

### 119. 伟大的命名变量名的方式

核心目的：更好的认识code和物理现象[我主要做物理方面的研究]。

``` java
// put elephant1 into fridge2
put(elephant1, fridge2);
openDoor(fridge2);
if (elephant1.alive()) {
  ...
} else {
   ...
}
closeDoor(fridge2);
...


void put(Elephant elephant, Fridge fridge) {
  openDoor(fridge);
  if (elephant.alive()) {
    ...
  } else {
     ...
  }
  closeDoor(fridge);
}
```

程序语言相比自然语言，是更加强大而严谨的，它其实具有自然语言最主要的元素：

1. 主语，
2. 谓语，
3. 宾语，
4. 定语，
5. 状语，
6. 补语
7. 名词，
8. 动词，
9. 如果,那么，
10. 否则，
11. 是，不是，

就好像[计算的要素][292]说的(计算基本符文认识, 符文之上就是法术，强大的模块就是强大的法术)
```org

1. 基础的数值。比如整数，字符串，布尔值等(固定数值)。
3. 表达式。包括基本的算术表达式，嵌套的表达式。
3. 变量(输入设备，固定数值,信息诞生的地方)和赋值语句。
4. 分支语句。(查看的地方)
5. 函数和函数调用(传输的方式，赋值，函数调用，返回值)
```

真正[优雅可读的代码(王垠)][290]，是几乎不需要注释的。如果你发现需要写很多注释，那么你的代码肯定是含混晦涩，逻辑不清晰的。
以下小标题均源自[王垠][290]

#### 伟大的线性思考方式

如果你看透了局部变量的本质——它们就是电路里的导线，那你就能更好的理解近距离的好处。变量定义离用的地方越近，导线的长度就越短。
你不需要摸着一根导线，绕来绕去找很远，就能发现接收它的端口，这样的电路就更容易理解。(想想看,||是不是代表并列逻辑，&代表汇合逻辑，交汇点)

上面的||和&写成笨一点的办法，就会清晰很多(大部分程序员的工作是处理程序的传递和分发)：

``` java
//bad
if (action1() || action2() && action3()) {
  ...
}


//good
if (!action1()) {
  if (action2()) {
    action3();
  }
}
```

而其实，流体力学【研究空气流动、液体流动的综合性物理学科】,电学【研究电流的流动学科】,代码学【研究代码的逻辑流动学科】,都应该归为流动问题，
都可以进行可视化，就像一根一根导线，如果排布好就不会让你的系统混乱<2018-05-29 16:24>。([绘画、雕塑是线条流][291]，音乐是字符流[计算机艺术也是字符流的感觉]、
电影是图片流，戏剧、小说等是剧情流[场景流])

坏:
``` java
void foo() {
  int index = ...;
  ...
  ...
  bar(index);
  ...
}
```

好：
``` java
void foo() {
  ...
  ...
  int index = ...;
  bar(index);
  ...
}
```

#### 废纸桶里面诞生的优秀文章[推敲、咀嚼、琢磨、提炼的能力]

有位文豪说得好：“看一个作家的水平，不是看他发表了多少文字，而要看他的废纸篓里扔掉了多少。” 我觉得同样的理论适用于编程。好的程序员，他们删掉的代码，比留下来的还要多很多。如果你看见一个人写了很多代码，却没有删掉多少，那他的代码一定有很多垃圾。

背后是逻辑学(大脑的有机流动的研究学科)。(需要练习、领悟)


`提炼很重要！结论最直接！`

#### 伟大的逻辑模块化(电路芯片)

真正的模块化，并不是文本意义上的，而是逻辑意义上的。一个模块应该像一个电路芯片，它有定义良好的输入和输出。
实际上一种很好的模块化方法早已经存在，它的名字叫做“函数”。每一个函数都有明确的输入（参数:电路上的引脚）和输出（返回值:电路上的引脚），
同一个文件里可以包含多个函数，所以你其实根本不需要把代码分开在多个文件或者目录里面，同样可以完成代码的模块化。
我可以把代码全都写在同一个文件里，却仍然是非常模块化的代码。

相关的code放在邻近的区域，从而构成模块化，文章也可以形成模块化，相同的研究问题放在临近的地方，形成模块化。【不要肤浅的认为不同
的文件夹，不同的文件就是模块化】(你给与模块文件名和模块名一致，并且pm结尾)


#### 伟大的两层盒子

如果我们忽略具体的内容，从大体结构上来看，优雅的代码看起来就像是一些整整齐齐，套在一起的盒子。
如果跟整理房间做一个类比，就很容易理解。如果你把所有物品都丢在一个很大的抽屉里，那么它们就会
全都混在一起。你就很难整理，很难迅速的找到需要的东西。但是如果你在抽屉里再放几个小盒子，把物品
分门别类放进去，那么它们就不会到处乱跑，你就可以比较容易的找到和管理它们[原来我家欣然的思想也是这样
在我们的家里也有类似的盒子]。


优雅的代码的另一个特征是，它的逻辑大体上看起来，是枝丫分明的树状结构（tree）。这是因为程序所
做的几乎一切事情，都是信息的传递和分支。你可以把代码看成是一个电路，电流经过导线，分流或者汇合。
如果你是这样思考的，你的代码里就会比较少出现只有一个分支的if语句，它看起来就会像这个样子：

``` org
if (...) {
  if (...) {
    ...
  } else {
    ...
  }
} else if (...) {
  ...
} else {
  ...
}
```
注意到了吗？在我的代码里面，if语句几乎总是有两个分支。它们有可能嵌套，有多层的缩进，
而且else分支里面有可能出现少量重复的代码。然而这样的结构，逻辑却非常严密和清晰。


### 120. Emacs eww(web browser) for windows10？


[emacs-notes][293] from [sachac][294]


[xml C parser and toolkit of gnome][369]对应的[libxml2仓库][371]
[libxml2 dll][370] put the libxml2.dll in the `C:\WINDOWS\system32\libxml2.dll`

[emacs eww上网][372],只不过我只是配置了libxml2.dll

哈哈哈！<2018-08-26 13:41>, 至此加入了libxml2.dll之后，你的eamcs支持eww和图片浏览了，太棒了!

安装eww-lnum链接使用数字表示，方便跳转!

有用的[gnutls][373]帮助

我发现emacs27.0.50包下的bin文件夹下的dll拷贝到25.3可以解决有些网页无法访问443端口问题！hack!!

为此org-alert或者org-ref就都可以使用了，因为之前都是提醒`libxml2库未安装`


让网页访问更加顺畅些!
```
  (use-package link-hint
    :ensure t
    :bind ("C-c f" . link-hint-open-link))
  )


```
####  Structure templates:


``` org
(setq org-structure-template-alist
      '(("s" "#+begin_src ?\n\n#+end_src" "<src lang=\"?\">\n\n</src>")
        ("e" "#+begin_example\n?\n#+end_example" "<example>\n?\n</example>")
        ("q" "#+begin_quote\n?\n#+end_quote" "<quote>\n?\n</quote>")
        ("v" "#+BEGIN_VERSE\n?\n#+END_VERSE" "<verse>\n?\n</verse>")
        ("c" "#+BEGIN_COMMENT\n?\n#+END_COMMENT")
        ("p" "#+BEGIN_PRACTICE\n?\n#+END_PRACTICE")
        ("l" "#+begin_src emacs-lisp\n?\n#+end_src" "<src lang=\"emacs-lisp\">\n?\n</src>")
        ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
        ("h" "#+begin_html\n?\n#+end_html" "<literal style=\"html\">\n?\n</literal>")
        ("H" "#+html: " "<literal style=\"html\">?</literal>")
        ("a" "#+begin_ascii\n?\n#+end_ascii")
        ("A" "#+ascii: ")
        ("i" "#+index: ?" "#+index: ?")
        ("I" "#+include %file ?" "<include file=%file markup=\"?\">")))

```

留着慢慢解决


### 121. krypy python demo


[krypy for python][295]

还有不错的matlab好玩的[Krylov.m][296]+ [linear-operator toolbox for matlab][297]

[Randomized Block Krylov Methods for Stronger and Faster Approximate Singular Value Decomposition][298]


``` org

pip install krypy
```



test code:

``` python
  #+BEGIN_SRC python
    import numpy
    from krypy.linsys import LinearSystem, Gmres

    # create linear system and solve
    linear_system = LinearSystem(A=numpy.diag([1e-3]+range(2, 101)),
                                 b=numpy.ones((100, 1)))
    sol = Gmres(linear_system)

    # plot residuals
    from matplotlib import pyplot
    pyplot.semilogy(sol.resnorms)
    pyplot.show()
  #+END_SRC

  #+RESULTS:
  : None

  

```


### 122. Ledger mode for balence bugdets(伟大的等价原则 收支平衡)

[ledger-mode][307] , a command tool for managing personal economic.

go to [ledger-website][308], and download the software for your operating system, put executable `ledger` in your path, 
so command window can execute the `ledger`. 从此开始记账。

投资和收益，从经济的角度管理好你的生活。

#### 1.Config:

```
(require 'ledger-mode)
(autoload 'ledger-mode "ledger-mode" "A major mode for Ledger" t)
(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

(defun ledger-accounts ()
    (mapcar 'list '(Construction-Bank MudanCard HuaBei Alipay Weixin Tourists Houselive Salary Fruits Eating Amusement Learning Sports)))

(defun ledger-add-entry (title in amount out)
  (interactive
   (let ((accounts (ledger-accounts)))
     (list (read-string "Entry: " (format-time-string "%Y-%m-%d " (current-time)))
           (let ((completion-regexp-list "Assets:"))
             (concat completion-regexp-list  (completing-read "What did you pay for? "  accounts)))
           (read-string "How much did you pay? " "RMB ")
           (let ((completion-regexp-list "Liabilities:"))
             (concat completion-regexp-list  (completing-read "Where did the money come from? " accounts))))))
  (insert title)
  (newline)
  (indent-to 4)
  (insert in "  " amount)
  (newline)
  (indent-to 4)
  (insert out))

```

#### 2. 添加账目


然后你可以使用`M-x ledger-add-entry` 先添加时间+标题，然后是你支付给哪个项目，接着是多少钱，然后是你的花销账户


于是可以得到如下信息，保存为test.ledger

```


2018-06-13 Travaling from Bj to 蓬莱
    Assets:Tourists  RMB 1800
    Liabilities:Construction-Bank
2018-06-13 Prepare food
    Assets:eating  RMB 300
    Liabilities:Construction-Bank
    

2018-06-13 purchase fruit
    Assets:fruits  RMB 150
    Liabilities:Construction-Bank
```

其中Assets其实代表你的花销，花费了所以是你的资产
而Liabilities一般代表你的所有收入来源。

#### 3. 解析账目


最后通过ledger(ledger布置于path路径下)解析一下即可

```
C:\Users\yzl\AppData\Roaming\.emacs.d>ledger -f test.ledger register Tour
18-Jun-13 Travaling from Bj to 蓬莱       Assets:Tourists                                RMB 1800           RMB 1800

C:\Users\yzl\AppData\Roaming\.emacs.d>ledger -f test.ledger balence
Error: Unrecognized command 'balence'

C:\Users\yzl\AppData\Roaming\.emacs.d>ledger -f test.ledger balance
            RMB 1800  Assets:Tourists
           RMB -1800  Liabilities:Construction-Bank
--------------------
                   0

C:\Users\yzl\AppData\Roaming\.emacs.d>ledger -f test.ledger balance
            RMB 2250  Assets
            RMB 1800    Tourists
             RMB 300    eating
             RMB 150    fruits
           RMB -2250  Liabilities:Construction-Bank
--------------------
                   0
                   
                   
 C:\Users\yzl\AppData\Roaming\.emacs.d>ledger -f test.ledger balance ^Assets ^Liabilities
            RMB 2250  Assets
            RMB 1800    Tourists
             RMB 300    eating
             RMB 150    fruits
           RMB -2250  Liabilities:Construction-Bank
--------------------
                   0                  
```
![ledger][309]

```
Type ‘C-c TAB’.  Ledger-mode will search for a Payee that has
the same beginning and copy the rest of the transaction to you new
entry.
```

[Introduction for ledger][306],现在用的Assets,  Liabilities源自于该网站。

  Assets are money that you have(拥有), and Liabilities are money that you owe(欠).
  “Liabilities” is just a more inclusive name for Debts.
  
At the highest level you have five sorts of accounts(最高级别的分层):

Expenses: where money goes,
Assets: where money sits,
Income: where money comes from,
Liabilities: money you owe,
Equity: the real value of your property.


  
```

          When you earn money, the money has to come from somewhere. Let’s call that somewhere “society”. 
    In order for society to give you an income, you must take money away (withdraw) from society 
    in order to put it into (make a payment to) your bank. When you then spend that money, it leaves 
    your bank account (a withdrawal) and goes back to society (a payment). This is why Income will 
    appear negative—it reflects the money you have drawn from society—and why Expenses will be positive—
    it is the amount you’ve given back. These additions and subtractions will always cancel each other out
    in the end, because you don’t have the ability to create new money: it must always come from somewhere,
    and in the end must always leave. This is the beginning of economy, after which the explanation gets 
    terribly difficult.
```

涡无法自发产生和消亡，正如钱无法自发产生和消亡,它总是从哪里产生，又消失到另外一个地方(This is the rule of economy). 
既然是市场，就应该有涨有跌。


```

        Based on that explanation, here’s another way to look at your balance report: every negative figure means
    that that account or person or place has less money now than when you started your ledger; and every positive
    figure means that that account or person or place has more money now than when you started your ledger. 
```

也就是说，当你某个账户为正时候，表示该账户有更多的钱，比你第一次使用ledger的时候，反之亦然。你不可能总是借账(negative),
borrow money from others .你还需要还账(given back),来保证守恒关系，经济规律本身就是一种守恒关系(经济规律的涡运动,
你是不是能够成为那个启动涡?!)
    Equity is like the value of something. 
    If you own a car worth $5000, then you have $5000 in equity in that car. In order to turn that car (a commodity)
into a cash flow, or a credit to your bank account, you will have to debit the equity by selling it.

    
    ```
    
When you start a ledger, you are probably already worth something. Your net worth is your current equity. 
By transferring the money in the ledger from your equity to your bank accounts, you are crediting the ledger 
account based on your prior equity. That is why, when you look at the balance report, you will see a large 
negative number for Equity that never changes: Because that is what you were worth (what you debited from 
yourself in order to start the ledger) before the money started moving around. If the total positive value
of your assets is greater than the absolute value of your starting equity, it means you are making money.

Clear as mud? Keep thinking about it. Until you figure it out, put not Equity(表示不包含起始的钱数 the starting point for ledger
)
at the  end of your balance command, to remove the confusing figure from the total.
    ```
    
Salary就是你的equlity源泉，不断的增长，代表你在不断挣钱。


    
```
 ledger -f test.ledger bal not Salary

```
![ledger2][313]

#### ledger黑色命令


`ledger -f test.ledger cleared -b 2018 -e 2019 `  从2018开始的 2019截止的
`ledger -f test.ledger cleared -b 2018 -e 2019 print >ledger-old.dat`  从2018开始的 2019截止的打印备份到ledger-old.dat

一般cleared可以用bal和reg 后面跟的可以是选项，比如`-b` `-e` `not` `^e`什么开头的正则表达式等
### 123.显示buffer和右键菜单


Ctrl+鼠标左键:显示buffer区域

![buffer][310]

Ctrl+鼠标右键:显示右键菜单项

![right][311]

### 124. emacs26.1的two bugs


clj-refractor.el版本不通过. org-babel的sh语言从ob-sh切换到ob-shell方式

界面鼠标下移不断地把文字往右推


### 125. emacs 中debug elisp

[debug elisp code in emacs][312]

```
报错了，使用d进入，然后不断d，直到结束，可以看到执行的list 表达式, q退出
```

### 126. ace-window

原来我的emacs系统中已经安装了[ace-windwos][314]

他的好处类似于[ace-jump-mode][315], 可以在多窗口中出现可以跳转到的[a-z] [0-9] [A-Z]

``` elisp

"C-c SPC" ==> ace-jump-word-mode

enter first character of a word, select the highlighted key to move to it.

"C-u C-c SPC" ==> ace-jump-char-mode

enter a character for query, select the highlighted key to move to it.

"C-u C-u C-c SPC" ==> ace-jump-line-mode

each non-empty line will be marked, select the highlighted key to move to it.

```


当只有两个frames时候，`M-x ace-window`默认和`C-x o`的命令一致

默认的ace-window相关命令

You can also start by calling ace-window and then decide to switch the action to delete or swap etc. By default the bindings are:
也就是，默认是j,对应的select buffer. 而摁下去`M-x ace-window`之后，会显示处窗口标号，还可以选择是否删除的命令,比如x,然后选择对应的frame 号。


    x - delete window
    m - swap windows
    M - move window
    j - select buffer
    n - select the previous window
    u - select buffer in the other window
    c - split window fairly, either vertically or horizontally
    v - split window vertically
    b - split window horizontally
    o - maximize current window
    ? - show these command bindings

```
(global-set-key (kbd "M-o") 'ace-window)
```
默认设置`M-O` 为窗口交换快捷键
<2018-06-26 20:28> 今天有使用它了


还有一些有趣的命令
```
　上一章我们看到有些命令加了C-x 4这个前缀，这一类命令都是用来操作多窗口的。

　　C-x 4 b bufname (switch-to-buffer-other-window) 在另一个窗口打开缓冲。
　　C-x 4 C-o bufname (display-buffer) 在另一个窗口打开缓冲，但不选中那个窗口。
　　C-x 4 f filename (find-file-other-window) 在另一个窗口打开文件。
　　C-x 4 d directory (dired-other-window) 在另一个窗口打开文件夹。
　　C-x 4 m (mail-other-window) 在另一个窗口写邮件。
　　C-x 4 r filename (find-file-read-only-other-window) 在另一个窗口以只读方式打开文件。

C-x 0 (delete-window) 来关闭当前窗口
C-x 1 (delete-other-windows) 关闭其它所有窗口
如果想连窗口打开的缓冲一并关掉使用C-x 4 0 (kill-buffer-and-window)。

C-x + 所有窗口等宽  C-x ^提高当前光标所在窗口
```

现在`C-x 4 b` 成为我比较经常用的。


### 127. helpful 系统

[helpful][320] 更好的显示帮助信息，并且相当全面。
<2018-07-03 21:08> 再次使用helpful

如果是源代码文档，如果添加下面[代码][368]到emacs配置文档，可以使用`M-x imenu`快速提取当前文档的变化和文档

``` emacs-lisp
(defun helpful--create-imenu-index ()
  "Create an `imenu' index for helpful."
  (beginning-of-buffer)
  (let ((imenu-items '()))
    (while (progn
             (beginning-of-line)
             ;; Not great, but determine if looking at heading:
             ;; 1. if it has bold face.
             ;; 2. if it is capitalized.
             (when (and (eq 'bold (face-at-point))
                        (string-match-p
                         "[A-Z]"
                         (buffer-substring (line-beginning-position)
                                           (line-end-position))))
               (add-to-list 'imenu-items
                            (cons (buffer-substring (line-beginning-position)
                                                    (line-end-position))
                                  (line-beginning-position))))
             (= 0 (forward-line 1))))
    imenu-items))

(defun helpful-mode-hook-function ()
  "A hook function for `helpful-mode'."
  (setq imenu-create-index-function #'helpful--create-imenu-index))

(add-hook 'helpful-mode-hook
          #'helpful-mode-hook-function)
```
### 128. 很有趣的suggest.el

通过打开特定的suggest窗口`M-x suggest`，然后
输入
1. Input信息

2. Output信息

3. 在suggestion 中敲`C-c C-c`,获得你要的结果

一些测试对

a. string
``` org
;; Inputs (one per line):
"foo bar"

;; Desired output:
"Foo Bar"

;; Suggestions:

```
b. list
``` org
;; Inputs (one per line):
(list 'a 'b 'c 'd)
'c

;; Desired output:
2

;; Suggestions:
```
c. file
``` org
;; Inputs (one per line):
"/foo/bar/baz.txt"

;; Desired output:
"baz.txt"

;; Suggestions:
```
d. list also
``` org
;; Inputs (one per line):
'(1 2 3 4 5)

;; Desired output:
15

;; Suggestions:
```

e. list3
``` org
;; Inputs (one per line):
'(a b c)

;; Desired output:
'c

;; Suggestions:
```

f. list4
``` org
;; Inputs (one per line):
'(a b c d)

;; Desired output:
'a

;; Suggestions:
```

### 129. clock your work, clock your life

Life need to reduce, to increase the importance of your life.(minus may be harder than plus)

[Abrams][322] do the post about the [capturing data][321] from Reading code, shell, web browser etc into your clocking file header
without changing buffer into the clock title(select, copy, change buffer, move cursor, paste,  而是 <C-f9> immediate paste the
data into it)


``` org
;;; http://www.howardism.org/Technical/Emacs/capturing-content.html
;;; copy item to the clock capture item
;;; 这种方式会弹出一个buffer框，等待你`C-c C-c` 才会输入到destination clock file
;;; 这种方式可以在你需要修改的前提下
(add-to-list 'org-capture-templates
             `("B" "Item to Current Clocked Task" item
               (clock)
               "%i%?" :empty-lines 1))
;; 立即输入到对应的destination clock file head  :immediate-finish t的作用
(add-to-list 'org-capture-templates
             `("E" "Contents to Current Clocked Task" plain
               (clock)
               "%i" :immediate-finish t :empty-lines 1))

;;; 有时候甚至你还需要偷懒 ，不想敲入`C-c c B or E` 于是你使用
(defun region-to-clocked-task (start end)
  "Copies the selected text to the currently clocked in org-mode task."
  (interactive "r")
  (org-capture-string (buffer-substring-no-properties start end) "E")); 注意这边是调用capture-template的E模板，不需要输入内容
  
  ;; 其实本质上org-capture使用org-capture-string 函数通过第三个参数指定模板！ 比如T  比如c等等

(global-set-key (kbd "C-<F9>") 'region-to-clocked-task)



```

很方便，由此进入了clock one task, do it -----investigate something, compare something, record something into your engineering notebook
(*.org) (M-x region-to-clocked-task)(绑定到f9,注意(kbd "<f9>") 而不是F9否则无效, finish something----clock out the current task, then clock another task!!

至于org-tree-slide的f9只是在激活tree-slide模式才生效

马克吐温说
```
    The secret of getting ahead is getting started. The secret of getting started is breaking your complex overhelming tasks 
    into small nageable tasks, and then start on the first one
```

马克吐温又说

```
    The secret of getting ahead is getting started. The secret of getting started is breaking your complex overhelming tasks 
    into small nageable tasks, and then start on the first one. The secret of getting started the first one  is just clocking
    on it!
```
----------


                                                   Go ahead, the young!

----------



### 130. Vinsualize your wiki into your brain

[org-brain][323] 金字塔原理的一个实现, 类似于[org-wiki][324], [vimwiki][325]的wiki系统，主要体现的思想是parent-children.

1. 当前heading(每一个heading都可以进行v，`M-x org-brain-visualize entry-your-select`, 也叫作active Thought(当前思考的内容)
2. 当前Heading的同级Heading(brother and sister..) ; map图的右边显示active thought(或者当前heading)的siblings图
3. 当前父Heading(p   大写P去除父heading）  map图当前heading上方显示
4. 当前子Heading(c   大写C去除子Heading)   map图当前heading下方显示
5. 不属与当前heading范畴的其他heading([Friend or jump heading][324] ) map图当前heading平行显示


org-brain最重要的是他的org-id(虽然也可以使用org file形式来进行，但是速度慢)

``` org

| Key        | Command                            | Description                                                |
|------------+------------------------------------+------------------------------------------------------------|
| m          | org-brain-visualize-mind-map       | Toggle between normal and mind-map visualization.          |
| j or TAB   | forward-button                     | Goto next link                                             |
| k or S-TAB | backward-button                    | Goto previous link                                         |
|------------+------------------------------------+------------------------------------------------------------|
| b          | org-brain-visualize-back           | Like the back button in a web browser.                     |
| h or *     | org-brain-new-child                | Add a new child headline to entry                          |
| c          | org-brain-add-child                | Add an existing entry, or a new file, as a child           |
| C          | org-brain-remove-child             | Remove one the entry’s child relations                     |
| p          | org-brain-add-parent               | Add an existing entry, or a new file, as a parent          |
| P          | org-brain-remove-parent            | Remove one of the entry’s parent relations                 |
| f          | org-brain-add-friendship           | Add an existing entry, or a new file, as a friend          |
| F          | org-brain-remove-friendship        | Remove one of the entry’s friend relations                 |
|------------+------------------------------------+------------------------------------------------------------|
| n          | org-brain-pin                      | Toggle if the entry is pinned or not                       |
| t          | org-brain-set-title                | Change the title of the entry.                             |
| T          | org-brain-set-tags                 | Change the tags of the entry.                              |
| d          | org-brain-delete-entry             | Choose an entry to delete.                                 |
| l          | org-brain-visualize-add-resource   | Add a new resource link in entry                           |
| C-y        | org-brain-visualize-paste-resource | Add a new resource link from clipboard                     |
| a          | org-brain-visualize-attach         | Run org-attach on entry (headline entries only)            |
| A          | org-brain-archive                  | Archive the entry (headline entries only)                  |
| o          | org-brain-goto-current             | Open current entry for editing                             |
| O          | org-brain-goto                     | Choose and edit one of your org-brain entries              |
| v          | org-brain-visualize                | Choose and visualize a different entry                     |
| r          | org-brain-visualize-random         | Visualize one of your entries at random.                   |
| R          | org-brain-visualize-wander         | Visualize at random, in a set interval. R again to cancel. |

```

`h` or `*`是指在当前active idea文件下产生一个headline，而`c`会产生一个新文件，并让其成为当前文件的下级文件

`t`我发现也挺好用的，经常你可能进行重命名

`v`为了快速定位到某个node，也可以直接用v然后输入entry即可。

####   going up to broader topics or drilling down into more specifics

Remember there are no hard and fast rules here. It’s your Brain. 
However, there are some basic information architecture principles that should be followed 
when organizing information sets. 
1. Things that are a part of a group should all be together below as Child Thoughts. 
2. Things that define a group should be above as Parent Thoughts. 
3. Things that are related but not part of the main group should be linked on the left as Jump Thoughts.

For instance, say you are building a Brain of your hobbies. “Hobbies” is the Parent Thought because it defines the group. 
Your actual hobbies, being subcategories of this concept, would then be displayed below as Child Thoughts.

You can continue to build a basic hierarchy of information with the Parent and Child relationships in TheBrain.  
For instance, one of your hobbies might be camping. Now you can drag and drop your favorite Web sites on camping gear, camp sites, national parks etc.


#### 配置

``` elisp
(use-package org-brain :ensure t
  :init
  (setq org-brain-path "~/.emacs.d/gtd/org_Brain")
  ;; For Evil users
  (with-eval-after-load 'evil
    (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
  :config
  (setq org-id-track-globally t)
  (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
  (push '("b" "Brain" plain (function org-brain-goto-end)
          "* %i%?" :empty-lines 1)
        org-capture-templates)
  (setq org-brain-visualize-default-choices 'all)
  (setq org-brain-title-max-length 12))

```

[ascii-art-to-unicode][328] is useful if you want org-brain-visualize-mode to look a bit nicer. After installing, add the following to your init-file:

``` org
(defun aa2u-buffer ()
  (aa2u (point-min) (point-max)))

(add-hook 'org-brain-after-visualize-hook #'aa2u-buffer)


``` 

遍历所有org-brain-path目录下的所有文件，以及文件内的heading，当做你的org-heading的Entry.
可以说很方便！

You can edit org-brain entries directly from org-mode.
You can use the default org-mode outline structure to define parent/children relationships,
but keep in mind that only entries with an ID property will be considered as entries to org-brain;
use `M-x org-id-get-create` to create an ID property to the current org-mode headline.
Another alternative is to use `M-x org-brain-refile` which will create the ids for you.

Think up, think down! Think others! All depends on you! Just free yourself

#### good workflow

org-brain只是针对当前entry的前后关系的展示（an visualization for current entry）

1. 打开一个idea的文件，然后`org-brain-visualization`,紧接着你就可以不断的`c` and `p` 甚至`f`(注意active idea一般指的是字体颜色为白色，有链接的entry都不是当前的entry!)
2. 当然现在的方式是你可以使用`C-c c` 选择`b`,然后可以针对某个具有id的entry添加内容(但不带id，也就是无法成为entry),
   为了可以成为id `M-x org-id`即可!
3. 当你在org-brain窗口下，你可以使用`v`跳转到你要的entry下，并进行相应的编辑(也就是变成白色字体),最简单的方式是摁下`<Cr>`键即可，
   一般只会显示两层关系(更多关系得不断点进去才会显示出来)！

其实org-brain的工作流程和emacs强大的info系统有点类似(`C-h i ` or `F1 h` or `LINK:info`), in the info system, you can use `LINK:info:org`
to find the help files for the org-mode.(刚才提到的org-brain的`V`类似于info系统的`g` 都可以用来快速定位entry的作用)

####  ascill to unicode make org-brain better visualization

[ ascii-art-to-unicode ][329] 快速转换把字符组成图变成线图形式，配合上vim的[ DrawIt ][330]会挺不错的.

然后在配合上[sketch.vim][331]的sketch功能，这个功能将会更加完美


```
+--------------+                               
| hello world  |                               
+--------------+                               

```

`M-x aa2u`之后，会直接把横线连城直线, 进一步可以学习[sketch的用法][332]

### 131. 重复命令


重复文件内的输入很简单，比如

`qa`,然后开始记录键盘宏，比如当前行`M-x org-id-copy`,接着向下移动几行，然后`q`,终止录入键盘信息

想要调用也很简单`@a`即可

`qa`, `tab`,向下移动`j`,`q`停止，关掉所有打开的


### 132. geiser: connect to scheme(伟大的Gei sir)

[geiser][336] is similar [cider][337], while cider connect emacs to clojure, geiser connect emacs to scheme(racket,chez,guile,Mit/GNU scheme,chicken etc)


```
M-x package-install geiser
M-x package-install ac-geiser

```

安装[ac-geiser][338]这样可以在Scheme Repl快速补全，总比没有不全的cmd好点.

[see the installlatin of geiser][333]

#### 使用racket

已安装了racket.

``` scheme
(setq geiser-active-implementations '(racket))
(setq geiser-racket-binary "c:\\Program Files\\Racket\\Racket.exe")
```

![racket][334]




#### 使用chez scheme 


``` scheme

(setq geiser-chez-binary "K:\\DanFriedMan\\ChezScheme\\a6nt\\bin\\a6nt\\scheme.exe")
(setq geiser-active-implementations '(chez))
```

![chez][335]


#### 小结 所有implementations

``` org
geiser-active-implementations is a variable defined in ‘geiser-impl.el’.

Its value is (chez)
Original value was 

(guile racket chicken chez mit chibi)


```


chez的执行`C-c C-c`编译org-babel源码快速度稍快于racket


rackekt还有一点比chez方便的地方，就是加载文件还比较方便

`,enter "hello.rkt"`

![raket2][339]

[Choosing-a-Scheme-Implementation][340]


#### 重用性问题

在[howardism literate-devops][76]也提到了重用性问题，但只是说可以把通过另外处理的数据输出给一个函数，而我需要的是一个代码段在多个函数快里面重用，
于是我想这可以用geiser提供的初始加载文件即可！

[scheme-init-file][343]

    You can also specify a couple more `initialisation `parameters.
For Guile, `geiser-guile-load-path` is a list of paths to add to its load path (and its compiled load path) when it’s started,
while `geiser-guile-init-file` is the path to an initialisation file to be loaded on start-up.
The equivalent variables for Racket are `geiser-racket-collects` and `geiser-racket-init-file`.


`geiser-racket-collects` 可以指定额外库路经
`geiser-racket-init-file` 可以指定初始化文件(一些基本函数)

在orgConf.el设置如下:

```
(setq geiser-racket-init-file "~/.emacs.d/GTD/scheme/sicp-init.rkt")  
```

这样每次添加完之后直接`C-c C-c` 那么不用重启Emacs也可以在org babel的代码块使用了！很方便！(但是chez没有该功能，设置无效，guile也许可以).




### 132. 添加scribble-mode,用racket写大论文

`M-x package-install scribble-mode`

在scheme-editing.el中添加geiser和paredit支持

```

(add-hook 'scribble-mode-hook #'geiser-mode)

(add-hook 'scribble-mode-hook     #'enable-paredit-mode)
```

![sribble-test][342]

[scribble-manual][341]

### 133. Origami 代码折叠


[ origami ][344]不错的代码折叠工具，可惜不支持scheme(有空看看[ origami-parser ][345])，

1. Perl
2. Java
3. Clojure
4. Python
5. elisp
6. C
7. C++
8. Go
9. Javascript
10. PHP


`M-x origami-toggle-all-nodes` 在程序文档挺有用的

`M-x origami-open-node` 打开节点

`M-x origami-open-node` 关闭节点

`M-x origami-forward-node` 节点向后
`M-x origami-next-node` 节点向前

`M-x origami-previous-node` 关闭节点


其他部分先用alexmurray的[ evil-vimish-fold ][346], 一方面需要安装[ evil ][211],另外自动安装了[vimish-fold][347]

Adds standard vim keybindings of `zf` and `zd` to create and delete folds (via vimish-fold) respectively.
Also hooks into evil so the usual vim keybindings for fold toggling (`za`), opening (`zo`), closing (`zc`) 
etc all work as expected with vimish-fold.

1. 创建 `zf`
2. 删除 `zd`
3. 打开 `zo`
4. 关闭 `zc`
5. toggle `za`
6. 调到上一节点 `zk`
7. 调到下一节点 `zj`

Finally, also supports navigation between folds using zj and zk.


最重要是，vimish-fold的fold是显示的，挺好看的一栏,perfect work！

快捷键定义
```

(evil-vimish-fold-mode 1)
(global-origami-mode 1)


(global-set-key (kbd "C-c C-o") 'origami-toggle-node)
(global-set-key (kbd "C-c C-p") 'origami-toggle-all-nodes)  ;; o和p彼此靠近，所以选择C-p

```
<2018-07-21 20:58>想起了他！

![vimish-fold][348]

### 134. Pandoc transform org files to docx

[ pandoc ][349]文件转换利器(A universal document converter)，支持各种编写格式文件(常用的markdown,wiki,org,docx etc）


转化为docx注意加上`-o`选项,如下，指定格式为org文件，目标格式为docx

1. org to word

``` org
pandoc -f org -t docx writing.org -o writing.docx
```

2. vimwiki to word

``` org
pandoc -f vimwiki -t docx diary.wiki -o diary.docx
```

### 135. Ace-link


[Ace-link][350]  makes `info-mode`,`eww-mode`,`help-mode`,`woman-mode` text into symbol link.

``` org
;; ace-link in your info-mode any other mode to create link in the text
(ace-link-setup-default)
```


### 136. Take to shell(cygwin)

1. setting in the org configuration
```  org
;;(sh . t)  new 26.1 change sh to shell
(org-babel-do-load-languages
 'org-babel-load-languages
 '(
   (shell . t)
    ...other languages
   ))
```
 
2. add exe to path

put the cygwin bin into path , so you can execute unix executable program correctly.


3. working in the org babel source code

<2018-08-02 22:23> good work, 在语言中写`(shell . t)` 在代码块中使用`bash`
``` org

#+BEGIN_SRC bash :dir "M:\\fluentYaw0\\"
  pwd
  ls sphere*.cas|awk -F"-" 'BEGIN{i=1}{print substr($5,0,length($5)-4),",",i; i=i+1}'
#+END_SRC

#+RESULTS:

```

use bash interpreter, and set the working dir by `:dir`


### 137. deft(make line of work funny)---text system(integrate vim and emacs working flow)

背景
```
Information: Whether we realize it or not, we collect a lot of it—interesting snippets, links, research for school or work, recipes, quotes, and a whole lot more.

No matter what line of work you're in, it's inevitable you have to take a few notes. Often, more than a few. If you're like many people in this day and age, you take your notes digitally.
```

use [ deft ][352] to find the notes directory you specified quickly(his idea from  http://notational.net/) 

1. 定义你的notes文件夹，比如 `(setq deft-directory "~/.emacs.d/GTD/")` <2018-09-11 03:46>的确是!
2. 过滤你的文件，比如`(setq deft-extensions '("txt" "tex" "org" "md"))` 
3. 设置你的deft快捷键  `(global-set-key [f8] 'deft)`
4. 让你得到的笔记通过文件名形式呈现，默认文件里头的首行文字 `(setq deft-use-filename-as-title t)`

当然你也可以统一设置

```
(use-package deft                                ;;
  :bind ("<f8>" . deft)                          ;;
  :commands (deft)                               ;;
  :config (setq deft-directory "~/.emacs.d/GTD/" ;;
                deft-extensions '("md" "org")))  ;;

```

![deft][351]


速度真的很快，和`c-c c-p f`搜索文件不同的是，deft把你的notes目录下的文件放在一起，搜索你搜索的字段可能存在哪个文件下！
所以deft是一个文本搜索神器，或者说等效于你的有道云笔记、印象笔记、onenote的搜索功能!


在deft页面下，使用`C-c Ret` 可以快速创建文件， 使用`C-c C-n`也可以创建文件名

```
https://github.com/jrblevin/deft/issues/21

Yes. The first element of deft-extensions is the default extension used to create new files. So, make sure "org" appears first. Example:

(setq deft-extensions '("org" "txt" "tex"))
```


```
To open a note, just scroll down to it and press Enter. Deft does a bit more, though.
According to Deft's developer, Jason Blevins, its primary operation is searching and filtering. 
Deft does that simply but efficiently. Type a keyword and Deft displays only the notes that
have that keyword in their title. That's useful if you have a lot of notes and want to find one quickly.
```

为了让日志文件也加入我的deft管理，只好重命名,TotalCmd(`Ctrl-M`重命名), 这样方便查找内容，虽然在calendar界面无法查到了
但是如果想查到也可以直接再重命名一下即可

并且vimwiki的文件夹移入GTD文件夹内，方便deft管理(That's cool, your text system).

#### Very good keyshort


`C-c C-f` in the screen of deft, you can find all the files with deft(like TotalCommand Ctrl+B, spread all files in 
different folders into one folder, then let you find the file you specified with regex strings) 

`C-c C-g` in the screen of deft, you can update the status of files.

#### export reference files to org


1. install perl Encode `cpanm Encode` , cpan是perl公会，大家都可以去哪边找需要的法术。

use dos cmd `tree > hello.org` to export 当前目录下的文件目录,然后由于存在中文乱码，于是得进行perl文件编码转换
``` perl
use strict;
use warnings;
use utf8;
use Encode;
 
#open(IN, "<", "hello.org");
#open(OUT, ">","helloP.org");
open(IN, "<", $ARGV[0]);
open(OUT, ">",$ARGV[1]);
 
while(<IN>){
	chomp();
    my $line = Encode::decode("GB2312", $_);   # 必须知道文件的原始编码格式
	$line = Encode::encode("UTF-8", $line);
	print OUT "$line\n";
}
close(IN);
close(OUT);

```


使用方式

``` perl

perl hello.pl hello.org helloModify.org
```

把所有命令集中于sol.bat(这个文件很重要，时不时用于更新),以后直接执行sol.bat即可进行更新!<2018-08-24 13:25>
``` cmd
tree /f I:\ScienceBase.Attachments\Turbine > c:/users/yzl/AppData/Roaming/.emacs.d/GTD/writing/referencesBak/yaw-1.org
perl hello.pl yaw-1.org yaw.org
del yaw-1.org


```

这样就可以导出文件目录，提供给deft进行文件名搜索了！当然其实你用everything查找也是一样的！

### 138. wrap-regions


[Abrams block wrapper][355]介绍了关于注释块的使用，并结合[wrap-region][360]
进行灵活使用，最后自定义了一个surround函数，方便进行text块的注释。

```
(global-set-key (kbd "C-+") 'surround)

(defun surround-text-with (surr-str)


```

可以通过如下几种方式,进行包裹

0. `#e` , emacs例子块
1. `#s` , emacs代码块
2. `#q` , emacs引用块
3. `(`
4. `[`
5. `{`
6. text


###  139. org-doing record what you are doing and done


[org-doing][356]源自[doing][357]---a command line tool, 用于记录你正在做

1. now(doing now "..."): add an entry
2. later(doing later "...") : add an item to the later section 
3. done(doing done ..) : Add an completed item with @done(date)
4. meanwhile: Finish any @meanwhile tasks and optionally create a new one



想法不错，但是org-agenda已经够好. 可以`C-c a T`输入`TODO`或者`DONE`或者其他，来快速找到你的任务状态

#### 伟大的project outline thinking

我又回看了Sachac的[baby-steps-org-todo][49], 学到了关于project outline的工作流

1. 新建一个project二级标题，(不要让过多的任务压死你，分成项目去做_
2. 在该标题下，建立TOOD三级标题，可以有多个TOOO([ ticklet ][374]可以说是org-mode比较重要的一个概念)
    1. 贴任务标签(`C-c q`)
    2. 指派(`C-c C-s`):不会忘记了deadline(不要太多，委托别人delegate,推迟postpone,去除eliminate
    3. 设置截止日期(`C-c C-d`)
    4. Clock in(`C-c C-x C-i`)  Clock-out (`C-c C-x C-o`) ...
    5. 设置任务状态(`C-c C-t`)
   
   拟合一下工作过程
   1. Tags(在这个过程中是有一个收集的前提的)
   2. Schedule
   3. Clock
   4. Job Status
   5. Tab
   
   再次温故[GTD流程][375]
  1. Collection. Collect all your stuff into a inbox.(基于一定主题的收集)
  2. Refile. Identify each stuff and make a decision on each of them with deleting, archive or generate a new task to do.
  3. Organization. Judge each stuff’s importance and time consideration, send(refile) them into specification destinations.
  4. Review. Check the list of things to be done, and mark them with some tags, deadlines, schedules and status.
  5. Do it. Select the right things to do with a right time and right place. 

   GTD核心：
   
``` org
    WRITE DOWN ALL THE STUFF IN YOUR MIND, AND ORGANIZE THEM INTO STREAM OF DOING THINGS.
    写下你脑中的所有琐事，然后重新组织他们，形成你自己的工作流
```
在这种工作流模式，怕多，所以得把任务紧密围绕你的project！这点很重要！ 通过标题，所以可以使用`Tab`不断切换(父子标题间切换,go through different level of visibility ,hide the detail and then edit the detail)overview状态，可以指定某个project为当前你要工作的project
(然后设置任务状态`doing`;`waiting`做了一些，合伙人还没做完中间，等待做；待做叫做`TODO`,这是任务的最后一个状态,做完重做叫`pending`)

在这种工作流模式下，一个task不要超过7个词语！

于是你也可以在你的org-agenda(`C-c a a`)设置任务状态( `t` ), 也可以设置日期( `C-c C-s`或者  `C-c C-d`), 也可以进行查看`Enter`进去.
`C-f`向后一周看agenda状态，`C-b`往前看一周

![Org-shifft][359]
markdown-mode参考标题10.

可以使用`C-c C-w` 来改变标题的层级关系（也就是说默认org文件是按照一个一个标题进行的), moving the entry to the appropriate place.

### 140. workspace by Perspective-el

[Perspective-el][367] is a tool to save the current project tagged workspace(keep project related buffers and windows setting separate
form other projects unit!)

```
Each perspective == A window configuration + a set of buffers related by project
```
Switching to a perspective activates its window configuration, and when in a perspective only its buffers are available by default.

[persp-projectile][365] connect projectile with perspective

<2018-09-05 11:55> 这个persp-mode挺好玩的，比如你保存一个code-mode
在保存一个org-mode,再保存一个main等，打开对应persp相当于打开一个新的
窗口, 比如你在code-mode打开两个水平平齐窗口，在main打开一个窗口，切换
persp视角看看吧！或者你在main视角上网, 好用!

#### shortkey for perspective


`C-x x`, then 

1. s -- persp-switch: Query a perspective to switch or create
2. k -- persp-remove-buffer: Query a buffer to remove from current perspective
3. c -- persp-kill : Query a perspective to kill
4. r -- persp-rename: Rename current perspective
5. a -- persp-add-buffer: Query an open buffer to add to current perspective
6. A -- persp-set-buffer: Add buffer to current perspective and remove it from all others
7. i -- persp-import: Import a given perspective from another frame.
8. n, `<right>` -- persp-next : Switch to next perspective
9. p, `<left>` -- persp-prev: Switch to previous perspective


### 141. 折腾的道理

生命在于折腾，越折腾越年轻。

    身后有余忘缩手，眼前无路想回头。

 

``` org
小说《乾隆皇帝》里乾隆有一段话，说他为什么要不停地折腾。
他说，他也知道射出去的箭，总有会落地的一天，强弩之末，势不能穿鲁缟。
他所能做的，就是拼命把弓拉满，力求让射出去的箭，晚一点落地。
```

### 142.真正的木匠

一根木匠的材质是一个木制艺术品诞生的前提，一个真正的木匠可以看到他！

耶稣也是一名木匠

1. 自然感
2. 保温感
3. 材质好

我[脑海中的橡皮擦][376]描述了关于木匠的本质。


一个真正的木匠，在他的心中也会有一座美丽的房子（你心中纵然没有，但也可以多多联想，但是你不是真正的木匠，通过你的包容
慢慢在心中滋生，无论多久，总是有那么一天；宽容的开启心中的窗户，去感受; 你有没有听过一句鸡汤：“宽容会在你心中打开一扇
窗户”， 宽容你的过去！宽容你的同事）

[诚信基础上建立起来的为人正直][377]

### 143. plantuml 绘制时序图

之前就了解过[plantuml][279],是一个用于绘制时序图、用例图等的java jar包（类似于[ditta][381]转变ASCII图为图形)

知道最近发现[vim-slumlord][380],一个vim插件，用于调用plantuml.jar绘制时序图, 于是也在emacs中接着学习, 增加了plantuml-mode。

[参考时序图用例][378]

[官网的getting started][382]

### 144. org-ref引用

org-ref设置

``` org

;; org-ref

(require 'org-ref)
(setq reftex-default-bibliography '("~/.emacs.d/GTD/orgref/reference.bib"))

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/.emacs.d/GTD/orgref/notes.org"
      org-ref-default-bibliography '("~/.emacs.d/GTD/orgref/reference.bib")
      org-ref-pdf-directory "~/.emacs.d/GTD/orgref/bibtex-pdfs/")
```

很方便添加额外的参考文献,比如下面的ref2.bib,这样就可以无限添加了!

```

;; see org-ref for use of these variables
(setq org-ref-bibliography-notes "~/.emacs.d/GTD/orgref/notes.org"
      org-ref-default-bibliography '("~/.emacs.d/GTD/orgref/reference.bib" "~/.emacs.d/GTD/orgref/ref2.bib")
      org-ref-pdf-directory "~/.emacs.d/GTD/orgref/bibtex-pdfs/")
```

`C-c ]` 表示`org-ref-helm-insert-cite-link`会去调用reference.bib里头的文献信息, 然后选择添加。

`C-c C-o` 打开菜单--`o`标识打开entry, `n`表示为这个entry添加说明【很喜欢，看完即可 做笔记】，相当于noteexpress的笔记的功能


#### What is helm-bibtex?

[helm-bibtex][384] 用于引用参考文献 using the method of helm。


#### what is org-ref?

[org-ref][385] 结合pdf_tools,helm-bibtex,helm等工具，组合成一个文献管理平台。


### 145. Copy 当前文件的路径名+文件名

```
(defun copy-file-name-to-clipboard ()
  "Copy the current buffer file name to the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (kill-new filename)
      (message "Copied buffer file name '%s' to the clipboard." filename))))
```


对应还有复制文件到某个路径， 对应的是`M-x copy-file`


###  146. weasel word deleted ###


[ Artbollocks-mode ][386] is written by [sachac][387] who is very keen on the development of the emacs.

通过该mode可以让一些关键字、重复字和你定义的术语显示出来，自己再进行修改

```
(use-package artbollocks-mode
  :defer t
  :load-path  "~/elisp/artbollocks-mode"
  :config
  (progn
    (setq artbollocks-weasel-words-regex
          (concat "\\b" (regexp-opt
                         '("one of the"
                           "should"
                           "just"
                           "sort of"
                           "a lot"
                           "probably"
                           "maybe"
                           "perhaps"
                           "I think"
                           "really"
                           "pretty"
                           "nice"
                           "action"
                           "utilize"
                           "leverage") t) "\\b"))
    ;; Don't show the art critic words, or at least until I figure
    ;; out my own jargon
    (setq artbollocks-jargon nil)))
```


### 147. 记录一下你的敲击速度


怎么用？ 当你打开一个.org文件，然后在一个标题下开始定时`C-c C-x C-i` 并且开始敲入单词，
一顿猛敲之后，关闭计时`C-c C-x C-o`,执行`M-x my/org-entry-wpm`，按照当前标题下的总字数/总时间得到你的 wpm.

```
(require 'org-clock)
(defun my/org-entry-wpm ()
  (interactive)
  (save-restriction
    (save-excursion
      (org-narrow-to-subtree)
      (goto-char (point-min))
      (let* ((words (count-words-region (point-min) (point-max)))
	     (minutes (org-clock-sum-current-item))
	     (wpm (/ words minutes)))
	(message "WPM: %d (words: %d, minutes: %d)" wpm words minutes)
	(kill-new (number-to-string wpm))))))

```

### 148. Auto insert file header with suffix specified


emacs已经提供了自动插入工具[AutoInsertMode][392],需要进行适当配置

Auto insert file header with specified file suffix have been
setted in the [setup_autoinsert.el][394], there are two different
kinds of config style out there in the file, 

1. yasnippet style and emacs
2. expression evaluation style

In addition, [Perl-mode yasnippet][393] have been injected in the current emacs config, which originates from
the [WolfgangMehner Perl-support][395].

### 149. color-rg代码重构利器

[color-rg][396]源自作者 [manateelazycat][398]在emacs-china.org中的讨论, 支持二次过滤和关键词跳转。
该作者实现了所有 [color-moccur.el][400]以及对应的[moccur-extendsion.el][401], 集成与color-rg中。

早先有人提出的方案是基于[ag][397]和[wgrep][399]
``` org
我一般用counsel-rg或者counsel-ag，然后C-c C-o搭配wgrep操作。当然，纯用ag或者rg也能实现，而且能分组显示。
强烈推荐rg.el 11，不是ripgrep。个人感觉这是目前效率最高的。感兴趣可以参考Centaur Emacs 6的配置。
```
参考 ：[rg.el][403], [Nuclear weapon multi-editing via ivy and Ag][405],[seagle0128][406]有很多不错的配置，我的
ivy和projectile的配置就是参考他的。所以现在`C-c p s s` `C-c p s r` `c-c s` `C-c r` 都得用`C-c C-o`配合wgrep使用了.<2018-09-23 15:12>有效 

结果： 使用`C-c p s s`进行搜索，使用`wgrep-change-to-wgrep-mode`进行替换,支持vim模式，使用`:1,4s///`替换也是可以的

当然wgrep还是[有点问题][407]
但是上面两种方式都是和evil-mode冲突的，进入wgrep或者color-rg事先得关掉`M-x evil-mode`.


``` org
默认情况下，rg是分组显示。您看到的上面我的截图没有分组，因为存在--vimgrep选项。

而color-rg.el执行的命令是： 
rg -i --column --color=always --smart-case -e "color-rg" c:/Users/yzl/AppData/Roaming/.emacs.d/customizations/color-rg/

在windows下的cmd没问题（linux和macs据作者说也没问题），但是emacs调用的是eshell，
在eshell输入上面命令行依然不是分组模式显示（每行都有文件路径名:行号:列号）

结论是： 在windows emacs中,需要在color-rg-build-command强制添加--heading选项，表示的意思是Print matches grouped by each file。

然后显示就正常，常用函数也可以使用。

```

原作者已经提交了[补丁][402], rg也有关于[Add line grouping option][404]的讨论

#### color-rg工作原理

1. rg.el 一旦改成分组模式显示分组, wgrep 就废了, color-rg.el 自己就包含了 rg.el 和 wgrep.el 功能, 不需要额外安装 wgrep.el
2. 默认尽量少问问题, 快速搜索, 搜索后觉得需要缩小范围再动态过滤不想看的文件类型
3. 默认智能的抓取当前光标处的单词(的确有), 而不仅仅是 symbol , 比如 CSS 的 class name, .foo 和 #foo 自动回转换成 foo 再搜索 (当然搜索之前都可以调), 避免大部分情况, 要各种删除 . 或者 # 才能搜索
4. 如果正则表达式搜索错误以后, 会智能探测(还没感觉到), 并用 literal 模式重新刷一遍 (这个 rg.el 没有)
5. 如果搜索出来的东西需要全部从文件中删除, 直接 C-c C-D 行了, 具体的更多贴心命令看上面的 keymap 吧.

还是有点问题,特别是Ret。

### 150. linum-mode 存在卡顿现象

以往有相关链接说明:

1. [只让编程语言具备行号: prog-mode集成linum-mode][408]
`(add-hook 'prog-mode-hook 'linum-mode)`
linum 大文件莫名卡死
2. [chenbin more than 300000 lines][409]

3. [Emacs Wiki Line Numbers][410]


据说[nlinum-mode更加快][413] because of its use of [jit-lock][412], [nlinum-relative][411], which is based on the nlinum-mode, only redisplays line numbers(看着花眼，于是不用了) when idle which is much more smoother especially with big files.

nlinum-mode的好处是当处于org文件时候，标题处的行号字体有加大的效果。


### 151. Youdao-dictionary

[youdao-dictionary][414] 有道词典接口for emacs.
配置文件在[init-utils.el][415].

快捷键`C-c y` 打开一个新的窗口，`C-c Y `直接一个右键弹出的效果(很棒!)

![youdao][416]


### 152. awesome tab

[awesome tab][417]分组定制显示buffer tabs. 比如 html,css,js 或者org为一组。

#### 配置

```
(add-to-list 'load-path (expand-file-name "~/elisp"))
(require 'awesome-tab)
(awesome-tab-mode t)
```

#### 常用命令


```
awesome-tab-forward-tab	切换到左边的标签
awesome-tab-backward-tab	切换到右边的标签
awesome-tab-forward-group	切换到前一个分组
awesome-tab-backward-group	切换到后一个分组
awesome-tab-kill-other-buffers-in-current-group
```

进一步可参考[emacs-china awesome-tab][418]

### 153. Record agenda activity inside specified days

1. You are changing the job status from TODO to DONE?
2. You are changing the head title tag?
3. Yes, you are working in the org-mode， and wanna log your recenty activiy?

That's it. Org-agenda show too many info, so you wanna simplify it, only shows the thing that changes in some periods.


The blog [record-org-mode-recent-activity][420] and [his agenda.el][419] will give you some advice about
how to remember your working process. Detailed message can traced into [.orgConf.el][421]


### 154. What is hook?

在之前有人讨论过

1. [add-hook和lambda][422] 得到结论add-hook返回函数对象值(函数也是first-order value) , 更准确的说是一个函数调用的表达式(lambda表达式)
add-hook 也不建议使用 lambda, 进一步参考[emacs-lisp-style-guide][423]
``` elisp

懒惰的写法：

(add-hook 'xxx-mode-hook
          (lambda ()
            ...)) ;;; 注意lambda前面没有单引号

不厌其烦的写法：

(defun foo (lambda ()
            ...))

(add-hook 'xxx-mode-hook 'foo)

```

add-hook 第二参数必须是 FUNCTION，不能是 S 表达式。答案也很简单：因为 add 之后，
将由 (funcall FUNCTION) 来执行传进来的函数，如果不是函数就会出错。而参数列表本身不具备约束力，传什么都可以。

`(add-hook 'xxx-mode-hook foo) `,那么 foo 就会被当作变量处理了, 所以写成了 `(add-hook 'xxx-mode-hook 'foo)`,
这样foo就解析成了symbol,而不进行求值，直到通过funcall的时候才求值，也就是函数调用!

``` elisp
(add-hook 'xxx-mode-hook 'foo)           ;; 指针（传引用）
(add-hook 'xxx-mode-hook (lambda ()...)) ;; 结构体（传值，一大拖东西）
```

#### xxx-mode-hook到底存的什么东西?

虽然传递函数名和 lambda 执行效果没什么区别，但还是有些需要注意的，例如：
``` elisp

(add-hook 'xxx-mode-hook 'foo) 之后，xxx-mode-hook 的内容是

(foo ;; <-- 最近添加
 bar
 quux
 ...)
 ```
而 `(add-hook 'xxx-mode-hook (lambda () (message "foo")))` 之后，其内容则是
``` elisp
((lambda () (message "foo")) ;; <-- 最近添加
 bar
 quux
 ...)
```
所以如果是传递的是函数名，将来需要改变函数 `foo `的行为，直接修改就可以了。但如果传递的是 `(lambda ...)`，要修改就比较麻烦了，必须整个 `(lambda ..)` 一字不漏抄一遍：

``` elisp
(remove-hook 'xxx-mode-hook (lambda () (message "foo")))
然后，修改，重新添加:

(add-hook 'xxx-mode-hook (lambda () (message "bar")))
```

所以说，偷懒是有代价的。

2. [add-hook怎样写比较好?][424]
 结论方便查看、修改、删除
 ```
 (let ((func (lambda () (message "Do something"))))
  (add-hook 'foo-hook func)
  (add-hook 'bar-hook func))
 ```
3. [分享一下我的LSP配置文件][425]
4. [linum-mode add into prog-mode-hook][408]

    A graph refers to a collection of nodes and a collection of edges that connect pairs of nodes.

Graph theory can be used to describe a lot of things,
but I'll start off with one of the most straightforward examples: maps.
You can think of graph theory as a way of encoding information about two aspects of a map: 

1. places to go, and 
2. ways to get there.

Each land mass can be represented by a point, and each bridge is just a line between two points.

1. Nodes: Places to be 
2. Edges: Ways to get there

公众交通: we love us some public transit. We've got buses, light rail, commuter rail, streetcars, and even an aerial tram.

Hook is a tool  for connection as edge, a bridge.

![A connection viliage][426]

[References make commit reachable][427], reference means commit blob, tag, local branch, remote branches etc(what is reachable? what is a -able? Make it able! Make it available).

----------

----------




[1]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/new.jpg
[2]:https://github.com/clojure-emacs/clj-refactor.el 
[3]:https://github.com/jaypei/emacs-neotree 
[4]:https://github.com/domtronn/all-the-icons.el 
[5]:https://github.com/magit/magit 
[6]:https://github.com/justbur/emacs-which-key 
[7]:https://github.com/tom-tan/hlinum-mode 
[8]:https://github.com/pashky/restclient.el 
[9]:https://github.com/T-J-Teru/browse-kill-ring 
[10]:https://github.com/auto-complete/auto-complete 
[11]:https://github.com/dracula/dracula-theme 
[12]:https://github.com/magnars/expand-region.el 
[13]:http://doc.norang.ca/org-mode.html#HowToUseThisDocument 
[14]:http://members.optusnet.com.au/~charles57/GTD/gtd_workflow.html#sec-1 
[15]:https://www.emacswiki.org/emacs/BookmarkPlus 
[16]:http://www.yinwang.org/blog-cn/2013/04/11/scheme-setup 
[17]:http://www.cnblogs.com/robertzml/archive/2010/02/19/1669204.html
[18]: https://www.masteringemacs.org/article/beginners-guide-to-emacs
[19]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/holyshit.jpg
[20]:https://www.braveclojure.com/basic-emacs/
[21]:https://github.com/magnars/multiple-cursors.el
[22]:https://github.com/tpope/vim-surround
[23]:https://github.com/emacs-evil/evil-surround
[24]:http://blog.csdn.net/redguardtoo/article/details/7222501/
[25]:https://github.com/Shougo/vimfiler.vim
[26]:http://oremacs.com/swiper/
[27]:https://github.com/abo-abo/swiper
[28]:https://github.com/emacs-helm/helm
[29]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/calenar.jpg
[30]:https://github.com/winterTTr/ace-jump-mode
[31]:https://github.com/emacs-evil/evil-surround
[32]:https://github.com/company-mode/company-mode
[33]:https://github.com/doitian/iy-go-to-char
[34]:https://github.com/emacsorphanage/key-chord
[35]:http://company-mode.github.io/
[36]:https://github.com/emacsorphanage/key-chord/blob/master/key-chord.el
[37]:http://emacsrocks.com/e13.html
[38]:http://emacsrocks.com/e10.html
[39]:https://segmentfault.com/a/1190000011000873
[40]:http://emacsrocks.com/e09.html
[41]:http://emacsrocks.com/e02.html
[42]:http://emacsrocks.com/e16.html
[43]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/dired.jpg
[44]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/ace.png
[45]:http://www.gnu.org/software/emacs/manual/html_node/elisp/Key-Binding-Conventions.html
[46]:https://github.com/magnars/.emacs.d 
[47]:https://github.com/rooney/zencoding
[48]:https://github.com/emacsfodder/move-text
[49]:https://github.com/sachac/baby-steps-org-todo/blob/master/index.org
[50]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/baby-org-mode.png
[51]:https://github.com/bbatsov/projectile
[52]:https://github.com/vim-ctrlspace/vim-ctrlspace
[53]:https://github.com/fxbois/web-mode
[54]:http://web-mode.org/
[55]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/projectile.jpg
[56]:http://lists.gnu.org/archive/html/emacs-orgmode/2010-03/msg00367.html
[57]:https://github.com/sachac/.emacs.d/blob/gh-pages/Sacha.org
[58]:https://github.com/nashamri/spacemacs-theme
[59]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/spacemacs.jpg
[60]:http://todotxt.org/
[61]:https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-thread-last-all
[62]:https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-thread-first-all
[63]:https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-unwind-all
[64]:https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-unwind
[65]:https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-cycle-privacy
[66]:https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-add-missing-libspec
[67]:https://github.com/clojure-emacs/clj-refactor.el/wiki/cljr-promote-function
[68]:https://zhidao.baidu.com/share/f280fd6b0524acc7f16e4b18eed0abc3.html
[69]:https://github.com/ffevotte/fortran-index-args
[70]:http://showterm.io/f5554b8857041dd28dd38#slow
[71]:https://github.com/rosenbrockc/fortpy-el
[72]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/f90mode.jpg
[74]:http://www.jianshu.com/p/1bd09e10f6db
[75]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/quicksort.png
[76]:http://www.howardism.org/Technical/Emacs/literate-devops.html
[77]:http://orgmode.org/worg/org-contrib/babel/how-to-use-Org-Babel-for-R.html
[78]:http://www.howardism.org/
[79]:http://www.howardism.org/Technical/Emacs/orgmode-wordprocessor.html
[80]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/org-bullet.jpg
[81]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/betterbullet.jpg
[82]:http://doc.norang.ca/org-mode.html#ClockingInDefaultTask
[83]:http://gettingthingsdone.com/
[84]:https://www.atlassian.com/git/tutorials/comparing-workflows
[85]:http://members.optusnet.com.au/~charles57/GTD/remember.html
[86]:https://github.com/jueqingsizhe66/zhaoEmacs.d 
[87]:http://www.fuzihao.org/blog/2015/02/19/org-mode%E6%95%99%E7%A8%8B/#%E5%88%97%E8%A1%A8
[88]:http://wenshanren.org/?p=327
[89]:http://www.3zso.com/archives/orgmode-babel.html
[90]:http://www.fuzihao.org/blog/2015/02/19/org-mode%E6%95%99%E7%A8%8B/#%E6%8F%92%E5%85%A5%E6%BA%90%E4%BB%A3%E7%A0%81
[91]:http://orgmode.org/worg/org-contrib/babel/languages.html
[92]:http://www.graphviz.org/Download_windows.php
[93]:https://github.com/howardabrams/clojure-snippets
[94]:https://github.com/magnars/.emacs.d/tree/master/snippets/clojure-mode
[95]:https://github.com/calvinwyoung/org-autolist
[96]:http://ftp.gnu.org/gnu/aspell/w32/Aspell-0-50-3-3-Setup.exe
[97]:https://stackoverflow.com/questions/3805647/enabling-flyspell-mode-on-emacs-w32
[98]:http://blog.binchen.org/posts/effective-spell-check-in-emacs.html
[99]:http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
[100]:http://aspell.net/win32/
[101]:http://www.howardism.org/Technical/Emacs/journaling-org.html
[102]:http://orgmode.org/org.html#Capture
[103]:https://github.com/howardabrams/dot-files/blob/master/emacs-org.org#auto-insert-a-journal-template
[104]:https://github.com/bastibe/org-journal
[105]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/oo.jpg
[106]:https://github.com/howardabrams/dot-files/blob/master/emacs-org.org#presentations
[107]:https://github.com/takaxp/org-tree-slide
[108]:https://github.com/hakimel/reveal.js/
[109]:https://github.com/hexmode/ox-reveal
[110]:https://github.com/Malabarba/speed-of-thought-lisp
[111]:https://github.com/Malabarba/speed-of-thought-clojure
[112]:https://github.com/Malabarba/
[113]:https://github.com/Malabarba/speed-of-thought-lisp/blob/89dfed2b5d2e9a3b16bfc47f169412b583626059/sotlisp.el#L238
[114]:https://github.com/Malabarba/speed-of-thought-clojure/blob/ceac82aa691e8d98946471be6aaff9c9a4603c32/sotclojure.el#L117
[115]:https://github.com/vvvvalvalval/scope-capture/blob/master/doc/Tutorial.md
[116]:https://github.com/vvvvalvalval/scope-capture
[117]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/purple.jpg
[118]:https://www.gnu.org/software/emms/
[119]:http://oss.netfarm.it/mplayer/
[120]:http://www.mplayerhq.hu/design7/news.html
[121]:http://darksun.blog.51cto.com/3874064/1339029
[122]:https://github.com/noinil/prelude/blob/75d41be0c5da3383cde1bd073c2aa5a9f4b7d792/personal/noinil.el#L195
[123]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/music.jpg
[124]:http://pragmaticemacs.com/emacs/dynamically-filter-directory-listing-with-dired-narrow/
[125]:http://lifegoo.pluskid.org/wiki/EnhanceDired.html
[126]:https://github.com/Fuco1/dired-hacks
[127]:http://pragmaticemacs.com/emacs/copy-and-paste-files-with-dired-ranger/
[128]:http://pragmaticemacs.com/emacs/install-packages/
[129]:https://github.com/jwiegley/use-package
[130]:https://www.masteringemacs.org/article/spotlight-use-package-a-declarative-configuration-tool
[131]:https://github.com/Fuco1/dired-hacks#dired-rainbow
[132]:http://pragmaticemacs.com/emacs/tree-style-directory-views-in-dired-with-dired-subtree/
[133]:http://graphviz.org/
[134]:https://github.com/theodorewiles/org-mind-map
[135]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/map.jpg
[136]:http://www.jianshu.com/p/cf43baf957a5
[137]:https://github.com/jwiegley/alert
[138]:https://github.com/spegoraro/org-alert
[139]:https://github.com/aki2o/log4e
[140]:http://wiki.ubuntu.org.cn/GPG/PGP
[141]:http://www.jianshu.com/p/bd4266fb4551
[142]:https://www.gnupg.org/download/
[143]:https://www.gpg4win.org/download.html
[144]:https://coldnew.github.io/4bb1df06/
[145]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/crypt.jpg
[146]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/gnupg.jpg
[147]:https://github.com/TeMPOraL/nyan-mode/
[148]:https://github.com/jueqingsizhe66/ranEmacs.d#56-%E5%A6%82%E4%BD%95%E6%8A%8Ajournalorg%E5%88%86%E6%88%90%E6%AF%8F%E5%A4%A9%E6%97%A5%E5%BF%97%E7%9A%84%E5%BD%A2%E5%BC%8F
[149]:https://github.com/jueqingsizhe66/ranEmacs.d#55-failed-enable-flyspell-mode-in-window10
[150]:https://github.com/jueqingsizhe66/ranEmacs.d#66-%E6%9C%89%E4%BA%9Btopic%E4%B8%8D%E6%83%B3%E8%AE%A9%E5%88%AB%E4%BA%BA%E7%9C%8B%E5%88%B0org-crypt
[151]:https://github.com/jueqingsizhe66/ranEmacs.d#16-multiple-cursorseditiingel
[152]:https://github.com/alphapapa/org-bookmark-heading
[153]:https://github.com/Fuco1/org-clock-budget
[154]:https://github.com/dfeich/org-clock-convenience
[155]:http://www.cnblogs.com/Open_Source/archive/2011/07/17/2108747.html#sec-8
[156]:http://www.360doc.com/content/11/1107/18/7735641_162571835.shtml
[157]:https://github.com/rust-lang/rust-mode
[158]:https://rustbyexample.com/
[159]:https://github.com/kwrooijen/cargo.el
[160]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/clock-in.png
[161]:http://mirrors.ustc.edu.cn/gnu/emacs/windows/
[162]: https://www.gpg4win.org/download.html
[163]:http://www.oracle.com/technetwork/java/javase/downloads/index.html
[164]:https://leiningen.org/
[165]:http://pan.baidu.com/s/1nvoo3DR
[166]:http://totalcmd.net/
[167]:http://www.voidtools.com/
[168]:http://caobeixingqiu.is-programmer.com/posts/6783.html
[169]:https://www.ibm.com/developerworks/cn/linux/l-vimdiff/
[170]:http://caobeixingqiu.is-programmer.com/posts/16691.html
[171]:https://zhidao.baidu.com/share/f280fd6b0524acc7f16e4b18eed0abc3.html
[172]:http://learnvimscriptthehardway.stevelosh.com/
[173]:http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/
[174]:https://wolfgangmehner.github.io/vim-plugins
[175]:https://www.cnblogs.com/yangwen0228/p/6418969.html
[176]:http://www.runoob.com/python/python-exercise-example12.html
[177]:https://github.com/jueqingsizhe66/ranEmacs.d#84-everything-and-totalcmd
[178]:https://www.emacswiki.org/emacs/OrgJournal
[179]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/b3fe1e49b86a79e6c54b28635e9c3ee7af8a6eb8/.orgConf.el#L540
[180]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/b3fe1e49b86a79e6c54b28635e9c3ee7af8a6eb8/.orgConf.el#L804
[181]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/b3fe1e49b86a79e6c54b28635e9c3ee7af8a6eb8/.orgConf.el#L858
[182]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/9d5718b40992c163f82c2c822cd309f5cbf32c40/.orgConf.el#L415
[183]:https://stackoverflow.com/questions/25671785/git-fatal-unable-to-auto-detect-email-address
[184]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/custom.el
[185]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/f9f7c4b308930b41f797931dade1de4bba27a776/customizations/ui.el#L159
[186]:https://orgmode.org/manual/Storing-searches.html#Storing-searches
[187]:http://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/
[188]:http://yannesposito.com/Scratch/en/blog/Vim-as-IDE/
[189]:https://github.com/ggreer/the_silver_searcher
[190]:https://github.com/ericdanan/counsel-projectile#the-counsel-projectile-ag-command
[191]:https://github.com/ericdanan/counsel-projectile
[192]:https://github.com/BurntSushi/ripgrep#installation
[193]:https://github.com/jacktasia/dumb-jump
[194]:https://github.com/jacktasia/dumb-diff
[195]:https://github.com/ggreer/the_silver_searcher#installing
[196]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/dumb-diff.png
[197]:https://github.com/jacktasia/dumb-jump/issues/168
[198]:https://github.com/monochromegane/the_platinum_searcher
[199]:http://blog.csdn.net/u011729865/article/details/53240101#%E6%95%88%E6%9E%9C%E7%9A%84%E8%A7%86%E9%A2%91%E6%AC%A3%E8%B5%8F
[200]:https://github.com/AndreaCrotti/yasnippet-snippets
[201]:https://github.com/joaotavora/yasnippet
[202]:https://www.zhihu.com/question/22149184
[203]:https://github.com/tacahiroy/ctrlp-funky
[204]:https://github.com/haya14busa/vim-asterisk
[205]:https://github.com/emacs-evil/evil-surround
[206]:https://github.com/tpope/vim-surround
[207]:https://github.com/syohex/emacs-git-gutter
[208]:https://github.com/airblade/vim-gitgutter
[209]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/git-gutter.png
[210]:https://github.com/pidu/git-timemachine
[211]:https://github.com/emacs-evil/evil 
[212]:https://github.com/redguardtoo/evil-matchit 
[213]:https://github.com/bling/evil-visualstar 
[214]:https://github.com/syl20bnr/evil-escape 
[215]:https://github.com/nschum/window-numbering.el 
[216]:https://jingyan.baidu.com/article/466506581be13ef549e5f82a.html 
[217]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/gnucrypt.png
[218]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/gpa.png
[219]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/secret.png
[220]:http://cnlox.is-programmer.com/posts/34114.html 
[221]:https://www.tuicool.com/articles/FBzANvE 
[222]:https://clisp.sourceforge.io/ 
[223]:http://www.sbcl.org/getting.html 
[224]:https://www.quicklisp.org/beta/ 
[225]:https://github.com/anwyn/slime-company 
[226]:https://github.com/slime/slime/issues/357 
[227]:https://github.com/slime/slime/issues/411 
[228]:https://github.com/andreer/lispbox 
[229]:https://github.com/redguardtoo/emacs.d 
[230]:https://www.zhihu.com/question/26964808?sort=created 
[231]:https://blog.csdn.net/u011729865/article/details/54292985 
[232]:https://blog.csdn.net/dalewzm/article/details/47621089 
[233]:https://github.com/zonuexe/emacs-presentation-mode 
[234]:https://opensource.com/article/18/2/how-create-slides-emacs-org-mode-and-revealjs 
[235]:http://nadeausoftware.com/articles/2007/11/latency_friendly_customized_bullets_using_unicode_characters 
[236]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/math.png
[237]:http://www.howardism.org/Technical/Emacs/literate-database-example.html 
[238]:https://www.gnu.org/software/emacs/manual/html_node/org/Priorities.html#Priorities 
[239]:https://www.gnu.org/software/emacs/manual/html_node/org/Property-syntax.html#Property-syntax 
[240]:https://github.com/jueqingsizhe66/ranEmacs.d#65-org-mind-map-%E7%BB%93%E5%90%88grpahviz%E5%88%9B%E5%BB%BA%E6%80%9D%E7%BB%B4%E5%AF%BC%E5%9B%BE 
[241]:https://github.com/theodorewiles/org-mind-map/issues/22 
[242]:http://www.howardism.org/Technical/Emacs/literate-programming-tutorial.html 
[243]:http://www.howardism.org/Technical/Emacs/calc.html#Top 
[244]:http://orgmode.org/manual/The-spreadsheet.html 
[245]:https://github.com/akirak/counsel-org-clock 
[246]:https://github.com/unhammer/org-mru-clock 
[247]:http://mbork.pl/2018-04-28_org-mru-clock 
[248]:http://jr0cket.co.uk/2013/10/create-cool-slides--Org-mode-Revealjs.html 
[249]: https://github.com/jr0cket/slides/blob/drafts/css/theme/jr0cket.css
[250]:http://www.graphviz.org/ 
[251]:http://yifanhu.net/GALLERY/GRAPHS/index.html 
[252]:http://emacser.com/emacs_graphviz_ds.htm 
[253]:https://blog.csdn.net/frankax/article/details/77035397 
[254]:http://graphviz.readthedocs.io/en/stable/ 
[255]:http://www.graphviz.org/documentation/ 
[256]:https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E5%87%AD%E8%AF%81%E5%AD%98%E5%82%A8 
[257]:https://github.com/chrisdone/elisp-guide 
[258]:http://ul.io/nb/2018/04/30/literate-analytics-with-org-babel/ 
[259]:http://pragmaticemacs.com/emacs/write-code-comments-in-org-mode-with-poporg/ 
[260]:http://ergoemacs.org/emacs/emacs_auto-activate_a_major-mode.html 
[261]:http://www.howardism.org/Technical/Other/code-reviews.html 
[262]:https://www.gnu.org/software/emacs/manual/html_node/elisp/Major-Modes.html#Major-Modes 
[263]:https://www.gnu.org/software/emacs/manual/html_node/elisp/Minor-Modes.html#Minor-Modes 
[264]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/cause.png
[265]:http://www.xuefo.net/nr/article47/474653.html 
[266]:http://irreal.org/blog/?p=7198 
[267]:https://github.com/bnbeckwith/writegood-mode 
[268]:http://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/ 
[269]:https://www.cnblogs.com/qlwy/archive/2012/06/15/2551034.html 
[270]:https://github.com/jueqingsizhe66/windowVimYe#%E8%B7%B3%E8%BD%AC%E5%8E%9F%E7%90%86 
[271]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/learning.png
[272]:https://github.com/rakanalh/emacs-dashboard 
[273]:https://github.com/bard/org-dashboard 
[274]:https://github.com/mhinz/vim-startify 
[275]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/org-dash.png
[276]:https://github.com/purcell/page-break-lines 
[277]:http://ergoemacs.org/emacs/emacs_line_ending_char.html 
[278]:https://github.com/dfeich/org-listcruncher 
[279]:http://orgmode.org/manual/Library-of-Babel.html 
[280]:https://dfeich.github.io/www/org-mode/emacs/reproducible-research/2018/05/20/reproducible-research-for-management.html 
[281]:http://org-babel.readthedocs.io/en/latest/ 
[282]:https://github.com/jueqingsizhe66/ranEmacs.d#102-orgmode-%E8%A1%A8%E6%A0%BC%E8%AF%B4%E6%98%8E 
[283]:https://github.com/dfeich/org-babel-examples/blob/master/library-of-babel/dfeich-lob.org 
[284]:https://github.com/dfeich/org-babel-examples/blob/master/calc/calc.org 
[285]:https://raw.githubusercontent.com/dfeich/org-babel-examples/master/tables/tables.org
[286]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/tablestar.png
[287]:http://kdr2.com/tech/emacs/1805-approach-org-ref-code-to-text.html
[288]:https://orgmode.org/worg/org-contrib/babel/library-of-babel.html
[289]: https://github.com/alphapapa/org-sidebar
[290]: http://www.yinwang.org/blog-cn/2015/11/21/programming-philosophy
[291]: https://www.jianshu.com/p/87a3c5002bde
[292]: http://www.yinwang.org/blog-cn/2018/04/13/csbook-chapter1
[293]: https://github.com/sachac/emacs-notes
[294]: https://github.com/sachac
[295]: https://krypy.readthedocs.io/en/latest/
[296]: https://github.com/optimizers/Krylov.m
[297]: https://github.com/mpf/spot/
[298]: https://papers.nips.cc/paper/5735-randomized-block-krylov-methods-for-stronger-and-faster-approximate-singular-value-decomposition
[299]: https://github.com/yangyangwithgnu/use_vim_as_ide#45-%E4%BB%A3%E7%A0%81%E6%94%B6%E8%97%8F
[300]: https://github.com/jueqingsizhe66/ranEmacs.d#109-%E4%BC%9F%E5%A4%A7%E7%9A%84awk-and-rename
[301]: http://blog.chinaunix.net/uid-21374062-id-3189744.html
[302]: http://blog.chinaunix.net/uid-10540984-id-3421486.html
[303]: https://segmentfault.com/a/1190000005713784
[304]: http://blog.sina.com.cn/s/blog_e08d52f50102wkou.html
[305]: http://blog.sina.com.cn/s/blog_e08d52f50102wkhn.html
[306]: https://www.ledger-cli.org/3.0/doc/ledger3.html#Introduction-to-Ledger
[307]: https://github.com/ledger/ledger-mode
[308]: https://www.ledger-cli.org/download.html
[309]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/ledger.png
[310]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/buffer.png
[311]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/right.png
[312]: https://www.jianshu.com/p/f509c9a9cac0
[313]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/ledger2.png
[314]: https://github.com/abo-abo/ace-window
[315]: https://github.com/winterTTr/ace-jump-mode
[316]: https://github.com/ericdanan/counsel-projectile
[317]: https://github.com/abo-abo/swiper
[318]: https://github.com/mkcms/ivy-yasnippet
[319]: https://github.com/kchenphy/counsel-world-clock
[320]: https://github.com/Wilfred/helpful
[321]: http://www.howardism.org/Technical/Emacs/capturing-content.html
[322]: http://irreal.org/blog/?p=7298
[323]: https://github.com/Kungsgeten/org-brain
[324]: https://github.com/caiorss/org-wiki
[325]: https://github.com/vimwiki/vimwiki
[326]: http://cachestocaches.com/2018/6/org-literate-programming/
[327]: http://cachestocaches.com/2016/9/my-workflow-org-agenda/
[328]: http://www.gnuvola.org/software/aa2u/
[329]: https://github.com/emacsmirror/ascii-art-to-unicode/blob/master/ascii-art-to-unicode.el
[330]: https://github.com/vim-scripts/DrawIt
[331]: https://github.com/vim-scripts/sketch.vim/blob/master/sketch.tut
[332]: https://github.com/jueqingsizhe66/windowVimYe#26-sketch-and-drawit
[333]:http://www.nongnu.org/geiser/geiser_2.html#Installation 
[334]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/racket.png
[335]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/chez.png
[336]: http://www.nongnu.org/geiser/
[337]: https://github.com/clojure-emacs/cider
[338]: https://github.com/xiaohanyu/ac-geiser
[339]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/racket2.png
[340]: http://www.nongnu.org/geiser/geiser_3.html#Choosing-a-Scheme-implementation
[341]: http://docs.racket-lang.org/scribble/getting-started.html
[342]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/scribble.png
[343]: http://www.nongnu.org/geiser/geiser_3.html#index-scheme-init-file
[344]: https://github.com/gregsexton/origami.el
[345]: https://github.com/gregsexton/origami.el/blob/master/origami-parsers.el
[346]: https://github.com/alexmurray/evil-vimish-fold 
[347]: https://github.com/mrkkrp/vimish-fold
[348]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/vimish-fold.png
[349]: https://github.com/jgm/pandoc/blob/master/INSTALL.md
[350]: https://github.com/abo-abo/ace-link
[351]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/deft.png
[352]: https://jblevins.org/projects/deft/
[353]: https://github.com/Pranshu258/emacsdoctor
[354]: https://github.com/howardabrams/dot-files/blob/master/emacs.org#multiple-cursors
[355]: https://github.com/howardabrams/dot-files/blob/master/emacs.org#block-wrappers
[356]: https://github.com/rudolfolah/org-doing
[357]: https://github.com/ttscoff/doing/
[358]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/shift.png
[359]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/shift2.png
[360]: https://github.com/rejeep/wrap-region.el
[361]: https://github.com/bbatsov/projectile/commit/e2762f20d65a4372d4eed766d1c71b09e9e4ef8c
[362]: https://github.com/bbatsov/projectile/commit/9c6e9813abec6e067c659e9107bf356086a95e04
[363]: https://github.com/ericdanan/counsel-projectile
[364]: https://github.com/bbatsov/helm-projectile
[365]: https://github.com/bbatsov/persp-projectile
[366]: https://github.com/asok/projectile-rail
[367]: https://github.com/nex3/perspective-el
[368]: http://xenodium.com/#basic-imenu-in-helpful-mode
[369]: http://xmlsoft.org/downloads.html
[370]: http://www.zlatkovic.com/libxml.en.html
[371]: https://gitlab.gnome.org/GNOME/libxml2/
[372]: https://blog.csdn.net/MathaDora/article/details/79468528
[373]: https://emacs.stackexchange.com/questions/27202/how-do-i-install-gnutls-for-emacs-25-1-on-windows/27251#27251
[374]: https://emacs.cafe/emacs/orgmode/gtd/2017/06/30/orgmode-gtd.html
[375]: http://ev6r.github.io/blog/2013/10/25/try-to-join-in-gtd-with-org-mode/
[376]: https://baike.baidu.com/item/%E6%88%91%E8%84%91%E6%B5%B7%E4%B8%AD%E7%9A%84%E6%A9%A1%E7%9A%AE%E6%93%A6/1929639?fr=aladdin
[377]: http://ev6r.github.io/blog/2015/01/09/liu-mei-xiao-jie-%28%5B%3F%5D-%29/
[378]: https://www.cnblogs.com/yangwen0228/p/6825560.html
[379]: http://plantuml.com/
[380]: https://github.com/scrooloose/vim-slumlord
[381]: http://blog.51cto.com/lavenliu/1630191
[382]: http://plantuml.com/starting
[383]: http://members.optusnet.com.au/~charles57/GTD/datetree.html
[384]: https://github.com/tmalsburg/helm-bibtex
[385]: https://github.com/jkitchin/org-ref
[386]: https://github.com/sachac/artbollocks-mode
[387]: https://github.com/sachac/.emacs.d/blob/gh-pages/Sacha.org#avoiding-weasel-words
[388]: https://github.com/SirVer/ultisnips
[389]: https://github.com/jueqingsizhe66/ranEmacs.d/tree/develop/snippets/python-mode
[390]: https://github.com/davidhalter/jedi-vim/
[391]: https://github.com/davidhalter/jedi
[392]: https://www.emacswiki.org/emacs/AutoInsertMode
[393]: https://github.com/jueqingsizhe66/ranEmacs.d/tree/develop/snippets/perl-mode
[394]: https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/setup-autoinsert.el
[395]: https://github.com/WolfgangMehner/vim-plugins
[396]: https://github.com/manateelazycat/color-rg
[397]: https://github.com/Wilfred/ag.el
[398]: https://emacs-china.org/t/topic/6313/61
[399]: https://github.com/mhayashi1120/Emacs-wgrep
[400]: https://www.emacswiki.org/emacs/color-moccur.el
[401]: https://www.emacswiki.org/emacs/moccur-extension.el
[402]: https://github.com/manateelazycat/color-rg/commit/cd1ed3974419339c60b87e088173b8cd499d673f
[403]: https://github.com/dajva/rg.el
[404]: https://github.com/dajva/rg.el/pull/5/commits/427338b3abb603a051744488290b13268664c14a
[405]: https://sam217pa.github.io/2016/09/11/nuclear-power-editing-via-ivy-and-ag/
[406]: https://github.com/seagle0128/.emacs.d
[407]: https://github.com/mhayashi1120/Emacs-wgrep/issues/36
[408]: https://emacs-china.org/t/emacs/6975
[409]: https://github.com/redguardtoo/emacs.d/issues/178
[410]: https://www.emacswiki.org/emacs/LineNumbers#toc1
[411]: https://github.com/CodeFalling/nlinum-relative
[412]: https://github.com/jwiegley/emacs-release/blob/master/lisp/jit-lock.el
[413]: https://elpa.gnu.org/packages/nlinum.html
[414]: https://github.com/xuchunyang/youdao-dictionary.el
[415]: https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/init-utils.el
[416]:https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/customizations/img/youdao.png
[417]: https://github.com/manateelazycat/awesome-tab
[418]: https://emacs-china.org/t/awesome-tab-1-0-emacs/7053
[419]: https://github.com/yqrashawn/.emacs.d/blob/master/modules/org-agenda.el
[420]: http://yqrashawn.com/2018/09/17/record-org-mode-recent-activity/
[421]: https://github.com/jueqingsizhe66/ranEmacs.d/blob/develop/.orgConf.el
[422]: https://emacs-china.org/t/topic/4815/78
[423]: https://github.com/bbatsov/emacs-lisp-style-guide#functions
[424]: https://emacs-china.org/t/topic/3671/3
[425]: https://emacs-china.org/t/lsp/6963
[426]: http://think-like-a-git.net/assets/images2/bridges_of_konigsberg.jpg
[427]: http://think-like-a-git.net/sections/experimenting-with-git/references-make-commits-reachable.html
[428]: https://github.com/magnars/multiple-cursors.el/issues/17
