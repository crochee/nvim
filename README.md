# nvim

## 安装nvim
neovim简称nvim，官网:https://github.com/neovim/neovim
根据release中的提示进行安装。安装完成后执行nvim --version查看版本,最好以官方最新为准。


安装完成后可选步骤，替换默认的vim执行nvim ~/bashrc修改文件内容如下
```text
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
```
## nvim插件安装
在$HOME/.config下克隆本仓库
```shell
git clone git@github.com:crochee/nvim.git
```
nvim打开即可
## 字体安装
参考https://github.com/ryanoasis/nerd-fonts
ubuntu安装说明
```shell
sudo unzip ${font} -d /usr/share/fonts/${font}
cd /usr/share/fonts/${font}
sudo mkfontscale #生成核心字体信息
sudo mkfontdir #生成字体文件夹
sudo fc-cache -fv #刷新系统字体缓存
```
