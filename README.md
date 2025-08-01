# Dotfiles


## 🚀 快速开始

### 安装步骤

1. **安装依赖**
   ```bash
   # 安装Oh My Zsh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   
   # 安装Spaceship主题
   git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
   ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
   
   # 安装插件
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z
   ```

2. **运行部署脚本**
   ```bash
   chmod +x setup_symlinks.sh
   ./setup_symlinks.sh
   ```

3. **重启终端**
   ```bash
   exec zsh
   ```

## 📁 项目结构

```
dotfiles/
├── README.md              # 项目文档
├── LICENSE                # MIT许可证
├── .gitignore            # Git忽略文件
├── setup_symlinks.sh     # 自动化部署脚本
├── zshrc                 # 主Zsh配置文件
├── zshenv                # Zsh环境变量配置
├── zprofile              # Zsh系统配置文件
└── bash_profile          # Bash配置文件
```

## ⚙️ 详细配置

### zshrc - 主配置文件

包含以下主要功能：

- **Oh My Zsh配置**: 主题和插件设置
- **NVM集成**: Node.js版本管理
- **开发工具别名**: 基于ni的Node.js开发命令
- **自定义函数**: 项目管理和VS Code集成

#### 主要插件
- `git`: Git命令别名和状态显示
- `pyenv`: Python版本管理集成
- `zsh-autosuggestions`: 命令自动建议
- `zsh-syntax-highlighting`: 语法高亮
- `zsh-z`: 智能目录跳转

#### Node.js开发别名
```bash
ns="nr start"      # 启动项目
nd="nr dev"        # 开发模式
nb="nr build"      # 构建项目
nt="nr test"       # 运行测试
nc="nr typecheck"  # 类型检查
```

#### 自定义函数
```bash
p <project>        # 跳转到Projects目录下的项目
mkcd <dir>         # 创建目录并进入
clonep <project>   # 克隆项目到Projects并打开VS Code
codep <project>    # 在VS Code中打开Projects下的项目
```

### zshenv - 环境变量配置

设置关键环境变量：
- `ZSH`: Oh My Zsh安装路径
- `NVM_DIR`: Node Version Manager路径
- `PYENV_ROOT`: Python版本管理器路径

### zprofile - 系统配置

处理系统级配置：
- Homebrew环境设置
- Pyenv路径初始化

### bash_profile - Bash配置

Bash shell环境配置：
- NVM (Node Version Manager) 初始化
- 本地环境变量加载

## 🔧 自定义配置

### 添加新的配置文件

1. 在`setup_symlinks.sh`中添加文件路径：
   ```bash
   home_file_paths=(
       "$HOME/.zshrc"
       "$HOME/.zshenv"
       "$HOME/.zprofile"
       "$HOME/.your_new_file"  # 添加新文件
   )
   repo_file_names=(
       "zshrc"
       "zshenv"
       "zprofile"
       "your_new_file"         # 对应的仓库文件名
   )
   ```

2. 创建配置文件并运行部署脚本

### 修改现有配置

1. 直接编辑仓库中的配置文件
2. 重启终端或运行`source ~/.zshrc`应用更改

### 添加自定义别名

在`zshrc`文件的别名部分添加：
```bash
alias your_alias="your_command"
```

## 🛠️ 故障排除

### 常见问题

**Q: Oh My Zsh主题不显示**
A: 确保Spaceship主题已正确安装：
```bash
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

**Q: 插件不工作**
A: 检查插件是否正确安装，确保路径正确：
```bash
ls -la ~/.oh-my-zsh/custom/plugins/
```

**Q: NVM命令未找到**
A: 确保NVM已安装并配置：
```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
```

**Q: 符号链接创建失败**
A: 检查文件权限和路径：
```bash
ls -la ~/.zshrc
./setup_symlinks.sh
```

### 重置配置

如果需要重置到默认配置：
```bash
# 备份当前配置
cp ~/.zshrc ~/.zshrc.backup

# 重新运行部署脚本
./setup_symlinks.sh

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。