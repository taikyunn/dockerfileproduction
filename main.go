package main

import (
	// "log"
	// "os"

	"github.com/gin-gonic/gin"
)

type User struct {
	Name string
	Age  int
}

func main() {
	r := gin.Default()
	r.LoadHTMLGlob("templates/*.html")

	r.GET("/", handler)
	r.Run(":3000")
}

func handler(c *gin.Context) {
	c.HTML(200, "index.html", gin.H{})
}
