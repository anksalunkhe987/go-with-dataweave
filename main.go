package main

import (
	"fmt"
	"log"
	"net/http"
)

func main() {
	defaultPort := "8080"

	fmt.Print("####################\n\n")
	fmt.Printf("Starting CRM Event Handler\n\n")
	fmt.Printf("####################\n\n")
	fmt.Printf("Listening on port %v...\n", defaultPort)

	http.Handle("/", http.FileServer(http.Dir("./static")))

	http.HandleFunc("/api/hello", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello from CRM Gateway")
	})

	log.Fatal(http.ListenAndServe(":"+defaultPort, nil))
}
