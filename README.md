## trans-add

订阅网页中的磁力链，并添加任务到 Transmission。

需要命令行工具 transmission-remote（一般在 transmission-cli 包中）。

## 使用

手动输入 URL：

```sh
$ trans-add.sh
https://dmhy.org/topics/rss/rss.xml?keyword=sonny+boy+mp4+%E6%98%9F%E7%A9%BA+%E7%AE%80
https://dmhy.org/topics/rss/rss.xml?keyword=megalobox+%E6%9E%81%E5%BD%B1+1080+GB
```

从文件读取 URL：

```sh
$ trans-add.sh <urls.txt # cat urls.txt | trans-add.sh
```

默认将已提交的磁力链保存在 `~/.config/transmission-daemon/trans-add.magnets`，也可手动指定：

```sh
$ trans-add.sh magnets.txt <urls.txt
```

一个典型的使用：

```sh
$ trans-add.sh <~/.config/transmission-daemon/trans-add.urls >>~/.config/transmission-daemon/trans-add.log 2>&1
```

添加到 cron 定时任务即可。
