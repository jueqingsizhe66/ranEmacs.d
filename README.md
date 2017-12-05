Okay , it comes from flyingmchine,
I have test in the two systems windows10
and ubuntu, all valid for newer.

参考我写的[emacs安装教程 for ubuntu and windows][39]

[原始记录版本][86]

*注意，[标题55][149]引入了flyspell问题，所以在windows得安装aspell,这个错误会在
调用org-agenda的时候出现(本质是调用flyspell mode失败)*

*注意，添加 (set-language-environment "utf-8")到init.el,这样新文件才会是utf-8编码风格*

*注意，在[标题66][150]我引入了org-crypt，所以安装了gnupg-win-3.0,得按照说明在你的电脑上安装，才可以具备加密功能(如果不加密不影响使用)*

C-c [a-z] and F5~F9是专门预留给用户自定义快捷键的，所有的major和minor都应该遵守这一规范。
[key-binding-convention][45]


## 当前.emacs.d安装和使用方法

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
带上[everything][167]比较好，这样就构成一个比较好的系统了。
7. 在使用`C-x C-f`需要设置一下你的项目目录，在custom.el对应修改一下，默认是我电脑上的`E:/clojure-home`是不对的。

截止到2017.11.19所用到的配件都在[emacs百度云][165],方便大家使用。另有一本the joy
of the clojure电子书.

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

### 2.为了使用类似nerdtree的neotree(ui.el)

click [neotree][3]

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

快捷键
```
c-x r l : 查询bookmark
c-x r m : 添加
c-x r b : 跳转
```

### 7. org-mode
[特详细的org-mode教程][13]

[GTD Workflow][14]

常用快捷键：

```
Tab打开标题
c-c c-n 光标沿标题方向向下移动
c-c c-p 光标沿标题方向向上移动
c-c c-q 添加标题的tag
c-c a 打开agender
c-c c-t 添加当前标题的todo
c-c c-d 添加当前标题deadline
c-c c-s 添加当前标题的schedule
<s Tab 添加src块
<e Tab  添加example快

c-c shift-< 打开calendar
c-c shift-> 添加calendar鼠标下的日期



M-RET 插入同级列表项
M-S-RET 插入有 checkbox的同级列表项
C-c C-c 改变 checkbox状态
M-left/right 改变列表项层级关系
M-up/dowm 上下移动列表项

输入C-c . 会出现一个日历，我们点选相应的时间即可插入。

```

注意，在标题上面或者总任务上面的尾巴添加上[%]或者[/]即可，emacs org-mode会自动进行计算任务的[总进度][87]。
只有在任务list才能添加勾选checkbox，标题不添加。

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

使用 `C-h i` 可以得到一个info window, 一个不错的帮助平台

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

`C-h k` 查看绑定快捷键的说明，比如你想查看`C-x #`表示什么意思，就可以执行该命令

### 13. mode helper system

使用`C-h m`等效于`M-x describe-mode` 可以很方便打开当前的buffer后缀对应的major-mode的帮助信息(一般一个
文件后缀对应一个major-mode和多个minor-modes)

比如在打开的markdown md后缀文件下，会打开markdown major-mode的帮助信息，有相关的
快捷键等帮助信息


### 14. 多窗口

C-x 5 2 打开当前window相同的frame
如果关掉当前frame，执行`C-x 5 0` 
如果关掉其他frame，执行`C-x 5 1` 

`C-x 1` delete other windows.
`C-x 2` split window below.
`C-x 3` split window right.
`C-x 0` delete the actie window right.


### 15. 括号相关的跳转

`C-M-d`  Move down into a  list

`C-M-u`  Move up   out  of a list

`C-M-n`  Move forward to the next list

`C-M-p`  Move backward to the previous list

`C-M-a`  Move to beginning of defun

`C-M-e`  Move to end       of defun


### 16. multiple-cursors(editiing.el)

Seen from [emacs-rocks-13][37]

#### 函数名

1. mc/mark-next-like-this （C->)
2. mc/edit-lines (C-S-c C-S-c 标记M-h区域)
3. mc/mark-previous-like-this(C-<)
4. mc/mark-all-like-this (C-c C-<)

按照官网简单配置

在没有[multiple-cursors][21]的前提下，你也可以使用`C-x r t` 来标记当前
光标前的所有行，当作一个矩形区域，然后可以多行编辑

当然你也可以使用`C-x Space Esc Down Down `等操作来标记多行

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

### 17. vim-surround to evil-surround

有时候需要给单词或者字段组合增加个双引号或者单引号， 亦或者括号，
在emcas可以使用[evil-surround][22](vim中使用[vim-surround][23])

add `(global-evil-surround-mode 1)` in the editing.el

add `evil-surround` into my-package list

### 18. mo-git-blame and ivy

#### 函数名

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


```


阅读[emacs教程][25]安装了git blame
git blame 安装
ivy ivy-dired-history all-the-icons-ivy ivy-rich

[ivy][27]是一个类似[emacs helm][28]的东西，可以方便查找buffer和file，

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

在.orgConf.el中添加的正确org-capture-templates，使用快捷键`C-c c`来捕捉你的想法并进行记录。 org-remember打算删掉。

有趣的大纲查看命令 
`C-c \`

有趣的添加当前日期命令
`C-c .`

在查看org-agenda 的时候可以使用`v`来选择你要看的日、月、年视图等

有趣的org帮助 `LINK:info:org:Top`.

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
`C-x r j` ,输入a即可
 
 有些人也说可以用C-SPC，然后C-x c-x跳转即可(进一步可以参考[标题16][151])。
 
 
### 26. transpose character and words

Seen from [emacs-rocks-2 and 3][41]

```
C-t transpose two chars

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

1. projectile-find-file  快捷键C-c p f

你可以使用 M-x projectile 进入projectile模式

在vim中有一个类似的软件叫做[Ctrl-space][52],[projectile][51]会把git或者其他代码管理软件，亦或者你的lein，maven，budler等
相关的文件夹当作一个project，如果啥都没有创建一个.projectile,那么该文件夹也会被识别为project


基本查找项目文件内的file(C-c是保留的快捷键)


`C-c p f`

![projectile][55]
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

1. [literal programming][76]
2. [how-to-use-Org-Babal-for-R][77]
3. [uncle glassman][78]  
4. [How I use Emacs and Org-mode to implement GTD][14]  very important for using org-mode in emacs!
5. [Norang: org-mode Organize Your life in plain text][82]
    6. [Remember Mode Tutorial][85] 早先使用remember mode,现在基本上替换为org capture即可
6. [Your Mind is for having ideas, not holding them---David Allen][83]  Use org-mode to hold it

a. Capture(collect what has your attention)
```
Use an in-tray, notepad, digital list, or voice recorder to capture everything that has your attention. 
Little, big, personal and professional—all your to-do’s, projects, things to handle or finish. 
```
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
d. Reflect(review frequently,weekly review, monthly review)
```
Look over your lists as often as necessary to trust your choices about what to do next. Do a weekly 
review to get clear, get current, and get creative. 
```
e. Engage(Simply do)
```
Use your system to take appropriate actions with confidence. 
```




### 45. 更好的org-mode bullet

Frome [uncle glassman][78] , found the setting about the bullets [orgmode-wordprocessor][79],

add code below in the .orgConf.el

```
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
```

![bullet style][80]

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


orgmode计时,
 在todo.org中，移到一个条目上，按`Ctrl-c Ctrl-x Ctrl-i`即可对该条目开始计时，`Ctrl-c Ctrl-x Ctrl-o`停止当前计时。
 如果在Agenda中，移到条目按I(大写)即可对该条目开始计时，O(大写)即可停止计时。


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
     先安装，并添加到path中，然后执行代码块， 所有的配置可以参考.orgConf.el。
     
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

 #+BEGIN_SRC dot :file a.png
       digraph colla_schema {  
           UserA -> UserB[label = "Liked", color = green];  
           UserB -> UserA[label = "Liked_By", color = red];  
       }  
 #+END_SRC

 #+RESULTS:
 [[file:a.png]]
 ```
 
 在每一个代码块执行`C-c C-c`即可看到结果（在windows配置完path之后，得重启系统,有些命令才有效)。
 很有意思的文学编程。( dame it, flyspell mode(flyspell mode 1) in the .orgConf.el)
 
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


### 58. Good job for clojure and lisp

Here is the good job from [Malabarba][112] who write the two completion feature for clojure and lisp;

1. elisp names [sotlisp][110]

   [elisp缩写词][113]
   
2. clojure names [sotclojure][111]

   [clojure缩写词][114]
   

使用方式得激活`M-x speed-of-thought-mode`
或者在editing.el中添加`(speed-of-thought-mode t)`即可。

clojure的定义函数，得在开启REPL模式下，才可以使用`C-c f`来调用`sotclojure-find-or-define-function`

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


有了这个插件真的挺方便的，勇气dired来，得心应手的.

在dired目录下使用i打开折叠目录(关闭折叠，展开)，;则可以用来折叠目录。


### 65. org-mind-map 结合grpahviz创建思维导图

1. [graphviz][133]安装

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


### 66. 有些topic不想让别人看到org-crypt

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


[org-clock-convienience][154]教会你如何在agenda画面中修改由于某件事情耽搁（但是你又是一哥时间控，无时无刻都在用org clock-in 模式)，这样你就需要多添加一些时间，
延长或者减少了,但是不用

[org-clock-budget][153]教会你的是如何给一件事情分配多少时间，并且安排很多星期去做，
如果一个星期没做完，那就下星期多分配点。

<2017-11-01 19:53> 现在迷上了clock，实现clock-in功能，然后在emacs的status-bar就会保留你正在进行clock的entry
在同一文件使用`C-c C-x C-j`实现跳转(工作流:捕捉一个todo，直接进行，然后等结束后才`C-c C-c`停止捕获,原先工作流是先创建不管clock in问题)。

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

重要的elisp编写技巧

```
C-M-d   Move down into a list(进入）
C-M-u   Move up outof a list(跳出)
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
parase, then `C-c C-<`


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


<hr/>
<hr/>



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
