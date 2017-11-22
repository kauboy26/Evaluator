#include "stack.h"
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

int main(void) {

	Stack *stack;
	int data;

	printf("Create new stack.\n");
	stack = create_stack();
	assert(size(stack) == 0);
	assert(stack->capacity == INIT_CAPACITY);
	printf("passes\n\n");

	printf("Push test. \n");
	for (int i = 0; i < INIT_CAPACITY; i++) {
		printf("pushing %d\n", i);
		assert(push(stack, i));
	}

	// Causing overflow.
	printf("pushing %d\n", 15);
	assert(push(stack, 15) == INIT_CAPACITY + 1);
	assert(capacity(stack) == INIT_CAPACITY * 2);
	// should have INIT_CAPACITY + 1 elements as of now.

	for (int i = 0; i < INIT_CAPACITY; i++) {
		printf("pushing %d\n", i + INIT_CAPACITY + 1);
		assert(push(stack, i + INIT_CAPACITY + 1) == i + INIT_CAPACITY + 2);
	}

	printf("Size should be %d, is %d\n", INIT_CAPACITY * 2 + 1, size(stack));
	assert(size(stack) == INIT_CAPACITY + INIT_CAPACITY + 1);
	// should have INIT_CAP * 2 + 1 elems.
	printf("Capacity should be %d, is %d\n", INIT_CAPACITY * 4, capacity(stack));
	assert(capacity(stack) == INIT_CAPACITY * 4);
	// would have regrown twice, so should have CAP * 4 space.
	printf("passes\n\n");


	printf("Pop test\n");
	printf("size is %d\n", size(stack));
	int size_r = size(stack);
	for (int i = 0; i < size_r; i++) {
		assert(pop(stack, &data) == INIT_CAPACITY * 2 - i);
		printf("Size should be %d, is %d\n", INIT_CAPACITY * 2 - i, size(stack));
		assert(data == INIT_CAPACITY * 2 - i);
	}

	printf("Size should be 0, is: %d\n", size(stack));
	assert(size(stack) == 0);
	printf("popping empty stack, expecting -1\n");
	assert(pop(stack, &data) == -1);
	printf("passes\n\n");

	printf("clear test\n");
	for (int i = 0; i < 10; i++) {
		assert(push(stack, i) == i + 1);
	}
	assert(pop(stack, &data) == 9);
	assert(data == 9);
	assert(peak(stack, &data) == 9);
	assert(data == 8);

	assert(clear(stack) == 0);
	assert(size(stack) == 0);
	assert(pop(stack, &data) == -1);
	assert(clear(NULL) == -1);
	printf("passes\n\n");

	printf("destroy test\n");
	size_r = capacity(stack);
	for (int i = 0; i < INIT_CAPACITY * 3; i++) {
		assert(push(stack, i) == i + 1);
	}
	// the capacity should have stayed the same.
	assert(capacity(stack) == size_r);
	printf("the size should be %d, is %d\n", INIT_CAPACITY * 3, size(stack));
	assert(peak(stack, &data) == INIT_CAPACITY * 3);
	assert(data == INIT_CAPACITY * 3 - 1);
	assert(destroy(stack) == 0);
	assert(destroy(NULL) == -1);
	printf("passes\n\n");

	printf("All cases passed.\n");
}