package app

import (
	"github.com/aws/aws-sdk-go/aws/session"
	awsS3 "github.com/aws/aws-sdk-go/service/s3"
	"github.com/qor/oss"
	"github.com/qor/oss/filesystem"
	"github.com/qor/oss/s3"
	"github.com/spf13/viper"
)

func NewStorage(session *session.Session) oss.StorageInterface {
	driver := viper.GetString("file_driver")

	var storage oss.StorageInterface

	switch driver {
	case "S3":
		region := viper.GetString("aws_default_region")
		if region == "" {
			region = "us-west-2"
		}

		storage = s3.New(&s3.Config{
			ACL:      awsS3.BucketCannedACLPrivate,
			Session:  session,
			Region:   region,
			Bucket:   viper.GetString("file_bucket"),
			Endpoint: viper.GetString("file_url"),
		})
	default:
		storage = filesystem.New("/public")
	}

	return storage
}
