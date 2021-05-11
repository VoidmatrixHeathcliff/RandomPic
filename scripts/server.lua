OS = UsingModule("OS")
Network = UsingModule("Network")

server = Network.CreateServer()

-- 图片文件夹路径
image_dir = "./image"

-- 图片列表
file_list = OS.ListDirectory(image_dir)

-- 返回随机图片
server:Get("/", function(req, res)
    local file_name = file_list[math.random(#file_list)]
    local image_file = io.open(OS.JoinPath(image_dir, file_name), "rb")
    res:SetContent(image_file:read("*a"), "image/png")
    image_file:close()
end)

-- 更新图片列表
server:Get("/update", function(req, res)
    file_list = OS.ListDirectory(image_dir)
    res:SetContent("update image file list success")
end)

-- 启动服务器，监听8080端口
server:Listen("localhost", 8080)