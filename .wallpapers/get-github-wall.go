package main

import (
	"context"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	"github.com/google/go-github/v75/github"
)

func main() {
	user := flag.String("u", "wtraceyv", "User whose repo we pull the image from.")
	repo := flag.String("r", "dotfiles", "Repo to pull image from.")
	imgPath := flag.String("p", ".wallpapers/boniverboniver.png", "Filepath within repo to pull image from.")
	flag.Parse()

	// get my token from het huis
	homeDir, err := os.UserHomeDir()
	if err != nil {
		log.Fatal(err.Error())
	}
	token, err := os.ReadFile(filepath.Join(homeDir, "git/aa-git-token"))
	if err != nil {
		fmt.Println("Couldn't open github PAT token file.")
		log.Fatal(err.Error())
	}
	tokenStr := strings.TrimSpace(string(token))

	// create client w/ token, grab content, check err
	client := github.NewClient(nil).WithAuthToken(tokenStr)
	rc, resp, err := client.Repositories.DownloadContents(context.Background(), *user, *repo, *imgPath, nil)
	if err != nil {
		log.Fatal(err.Error())
	}
	if resp.StatusCode != 200 {
		log.Fatalf("Status code grabbing resource was not 200, but %d", resp.StatusCode)
	}
	content, err := io.ReadAll(rc)
	if err != nil {
		log.Fatal(err.Error())
	}

	os.WriteFile("obtained_wallpaper", content, 0644)

	cmd := exec.Command("sh", "-c", "feh --no-fehbg --bg-fill ~/.wallpapers/obtained_wallpaper")

	_, err = cmd.CombinedOutput()
	if err != nil {
		log.Fatalf("%s", err.Error())
	}
}
