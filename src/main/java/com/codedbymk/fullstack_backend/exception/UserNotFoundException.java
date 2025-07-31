package com.codedbymk.fullstack_backend.exception;

public class UserNotFoundException extends RuntimeException {
    public UserNotFoundException(Long id) {
        super("Could not find user!!!");
    }
}
