package main

import "fmt"

type Member struct {
	Name           string
	Email          string
	MembershipType string
}

func MemberDetails(m Member) string {
	return "Hello, " + m.Name + "! your membership type is " + m.MembershipType
}

func main() {
	members := []Member{
		{Name: "John Doe", MembershipType: "Basic"},
		{Name: "Jane Smith", MembershipType: "Premium"},
		{Name: "Alice Johnson", MembershipType: "VIP"},
	}

	for _, m := range members {
		fmt.Println(MemberDetails(m))
	}
}
