# CarrierWave for Aliyun OSS

This gem forked from carrierwave-aliyun and adds CRUD functionality for [Aliyun OSS](http://oss.aliyun.com) to [CarrierWave](https://github.com/jnicklas/carrierwave/)

## Installation

```bash
gem install carrierwave-aliyun-crud
```

## Using Bundler

```ruby
gem 'rest-client'
gem 'carrierwave-aliyun-crud'
```

## Configuration

创建脚本 `config/initializes/carrierwave.rb` 填入下面的代码，并修改对应的配置：

```ruby
CarrierWave.configure do |config|
  config.storage = :aliyun
  config.aliyun_access_id = "xxxxxx"
  config.aliyun_access_key = 'xxxxxx'
  # 需要在 Aliyum OSS 上面提前创建一个 Bucket
  config.aliyun_bucket = "simple"
  # 是否使用内部连接，true - 使用 Aliyun 局域网的方式访问  false - 外部网络访问
  config.aliyun_internal = true
end
```
## Usage

上传文件

```ruby
CarrierWave::Storage::Aliyun::Connection.new(options).put relative_store_url, File.read(file_path)
```

删除文件

```ruby
CarrierWave::Storage::Aliyun::Connection.new(options).delete relative_store_url
#如果删除的文件不存在，不会有异常
```
