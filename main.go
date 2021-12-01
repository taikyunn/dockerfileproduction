package main

import (
	"github.com/gin-gonic/gin"
)

type User struct {
	Name string
	Age  int
}

func main() {
	// ポートの指定は不要
	r := gin.Default()
	r.LoadHTMLGlob("templates/*.html")

	r.GET("/", handler)
	r.Run(":3000")
}

func handler(c *gin.Context) {
	c.HTML(200, "index.html", gin.H{})
}
