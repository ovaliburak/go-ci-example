package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		if r.URL.Path == "/" {
			fmt.Fprintf(w, "Hello, you've requested: %s\n", r.URL.Path)
		} else {
			fmt.Fprintln(w, "There is no content")
		}

	})

	fmt.Printf("Server started at 2000 port.")
	http.ListenAndServe(":2000", nil)

}
