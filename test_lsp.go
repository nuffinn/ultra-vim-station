package main

import "fmt"

// TestStruct is a simple struct for testing LSP functionality
type TestStruct struct {
	Name  string
	Value int
}

// NewTestStruct creates a new TestStruct instance
func NewTestStruct(name string, value int) *TestStruct {
	return &TestStruct{
		Name:  name,
		Value: value,
	}
}

// GetName returns the name of the TestStruct
func (t *TestStruct) GetName() string {
	return t.Name
}

// SetValue sets the value of the TestStruct  
func (t *TestStruct) SetValue(value int) {
	t.Value = value
}

func main() {
	// Create a new instance - test gd on NewTestStruct
	test := NewTestStruct("example", 42)
	
	// Test method calls - test gd on GetName
	name := test.GetName()
	fmt.Println("Name:", name)
	
	// Test gr on SetValue by using it multiple times
	test.SetValue(100)
	test.SetValue(200)
	
	fmt.Printf("Test struct: %+v\n", test)
}
