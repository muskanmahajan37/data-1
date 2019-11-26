package main

import "os"

func main()  {
	file, _ := os.Open("file.go") // For read access.
	file.Name()
}