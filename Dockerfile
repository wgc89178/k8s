# 使用官方Nginx基础镜像
FROM nginx
 
# 将一个简单的index.html文件复制到Nginx服务器的网页根目录
COPY index.html /usr/share/nginx/html/index.html
