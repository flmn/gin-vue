package main

import (
	"github.com/gin-contrib/static"
	"github.com/gin-gonic/gin"
)

func main() {
	gin.SetMode(gin.ReleaseMode)
	gin.DisableConsoleColor()

	r := gin.Default()

	r.Use(static.Serve("/", static.LocalFile("./dist", false)))

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	r.Run(":8888")
}
