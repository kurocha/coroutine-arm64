/*
 *  This file is part of the "Coroutine" project and released under the MIT License.
 *
 *  Created by Samuel Williams on 10/5/2018.
 *  Copyright, 2018, by Samuel Williams. All rights reserved.
*/

#pragma once

#include <assert.h>
#include <string.h>

#if __cplusplus
extern "C" {
#endif

#define COROUTINE __attribute__((noreturn)) void

const size_t COROUTINE_REGISTERS = 0xb0 / 8;

typedef struct
{
	void **stack_pointer;
	void *argument;
} CoroutineContext;

typedef COROUTINE(* CoroutineStart)(CoroutineContext *from, CoroutineContext *self);

static inline void coroutine_initialize(
	CoroutineContext *context,
	CoroutineStart start,
	void *argument,
	void *stack_pointer,
	size_t stack_size
) {
	/* Force 16-byte alignment */
	context->stack_pointer = (void**)((uintptr_t)stack_pointer & ~0xF);

	context->argument = argument;

	if (!start) {
		assert(!context->stack_pointer);
		/* We are main coroutine for this thread */
		return;
	}

	context->stack_pointer -= COROUTINE_REGISTERS;
	memset(context->stack_pointer, 0, sizeof(void*) * COROUTINE_REGISTERS);

	context->stack_pointer[0xa0 / 8] = (void*)start;
}

CoroutineContext * coroutine_transfer(CoroutineContext * current, CoroutineContext * target);

static inline void coroutine_destroy(CoroutineContext * context)
{
}

#if __cplusplus
}
#endif
