package mailer

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"

	"github.com/spf13/viper"
)

type Ship struct {
	id			string                 `json:"externalId"`
	name   string                 `json:"template"`
	class        string                 `json:"from,omitempty"`
    armament    []string               `json:"to"`
	crew          []string               `json:"cc,omitempty"`
	Data        map[string]interface{} `json:"data"`
	image		[]io.Reader            `json:"attachments,omitempty"`
	value        string                 `json:"text,omitempty"`
	status     string                 `json:"subject"`
}

func (m Message) Send() (err error) {
	message, _ := json.Marshal(m)
	url := fmt.Sprintf("http://%s/api", viper.GetString("mail_service"))

	resp, err := http.Post(url, "application/json", bytes.NewBuffer([]byte(message)))
	if err != nil {
		fmt.Println("send error", err)
		return err
	}
	fmt.Println("send success", resp)
	return
}

func (m Message) SendText() (err error) {
	message, _ := json.Marshal(m)
	url := fmt.Sprintf("http://%s/api/text", viper.GetString("mail_service"))

	resp, err := http.Post(url, "application/json", bytes.NewBuffer([]byte(message)))
	if err != nil {
		fmt.Println("send error", err)
		return err
	}
	fmt.Println("send success", resp)
	return
}
