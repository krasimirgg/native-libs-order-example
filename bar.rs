use std::os::raw::c_int;

extern "C" {
    pub fn f() -> c_int;
}

pub fn b() -> c_int {
    return unsafe { f() } + 1;
}
