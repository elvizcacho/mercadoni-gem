#!/usr/bin/env ruby

require 'aws-sdk'

server_names = ARGV.select do |arg|
  !(arg =~ /--/)
end

params = ARGV.select do |arg|
  arg =~ /--/
end

aws_key = ENV['MERCADONI_AWS_KEY']
aws_secret = ENV['MERCADONI_AWS_SECRET']

Aws.config.update({
                    region: 'us-west-2',
                    credentials: Aws::Credentials.new(aws_key, aws_secret)
})

unless server_names.include? 'doc'
  thr = Thread.new {
    while true do
        #`afplay .alert.mp3`
      end
      }

      ec2 = Aws::EC2::Client.new

      def mapping_instances_names(name)
        names = {
          'client' => { name: 'test_client', env: 'master' },
          'admin' => { name: 'admin_aws', env: 'master' },
          'shopper' => {name: 'shopper_aws', env: 'master' },
          'socket' => { name: 'socket', env: 'master' },
          'catalog' => { name: 'catalog', env: 'master' },
          'partner' => { name: 'partner', env: 'master' },
          'client-live-v2' => { name: 'client-live-v2', env: 'master' },
          'bi' => { name: 'bi', env: 'dev' },
          'client-dev' => { name: 'client-dev', env: 'dev' },
          'admin-dev' => { name: 'admin-dev', env: 'dev' },
          'shopper-dev' => { name: 'shopper-dev', env: 'dev' },
          'catalog-dev' => { name: 'catalog-dev', env: 'dev' },
          'socket-dev' => { name: 'socket-dev', env: 'dev' },
          'partner-dev' => { name: 'partner-dev', env: 'dev' },
          'bi-dev' => { name: 'bi-dev', env: 'dev' }
        }[name]
      end

      server_names.each do |server_name|
        server = mapping_instances_names(server_name)
        server_name = server[:name];
        env = server[:env]
        puts "target: #{server_name}"
        puts "env: #{env}"
        resp = ec2.describe_instances({
                                        filters: [
                                          {
                                            name: 'key-name',
                                            values: [server_name],
                                          },{
                                            name: 'instance-state-code',
                                            values: ['16']
                                          }
                                        ],
        })

        ips = []
        resp.reservations.each do |reservation|
          reservation.instances.each do |instance|
            ips << instance.public_ip_address
          end
        end

        ips.each do |ip|
          if params.include? '--logs'
            exec('ssh -t app@%{ip} "source ~/.nvm/nvm.sh && tailf \`forever logs | awk \'FNR==3 {print \$4}\'\`"' % {ip: ip})
          else
            puts `git push app@#{ip}:app.git #{env}`
          end
        end
      end
      Thread.kill(thr)
      else
        `cd .. && node node_modules/apidoc/bin/apidoc -i controllers -o documentation`
        path = File.expand_path("..", Dir.pwd)
        path += '/documentation'
        bucket = 'api-doc.mercadoni.com'
        s3 = Aws::S3::Resource.new
        files = Dir.glob("#{path}/**/*").select { |f| File.file?(f) }
        files.each do |file|
          aws_path = file.to_s.scan( /documentation\/(.+)/).last.first
          obj = s3.bucket(bucket).object(aws_path)
          obj.upload_file(file.to_s, acl:'public-read')
          puts obj.public_url
        end
      end
