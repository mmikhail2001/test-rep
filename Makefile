LIB = fib_lib
BUILD_DIR = build
TARGET = ./${BUILD_DIR}/fib
PATH_LINTERS_SCRIPT = linters/run.sh
TEST_OPT 		= OFF
DEBUG_OPT 		= ON
SANITIZE_OPT 	= OFF

.PHONY: check build test run

# Изменения в CMakeLists требует make build
# make build = cmake && cmake --build 
build: clean
	mkdir ${BUILD_DIR}
	cd ${BUILD_DIR} && cmake .. -DTEST_OPT=${TEST_OPT} -DDEBUG_OPT=${DEBUG_OPT} -DSANITIZE_OPT=${SANITIZE_OPT} && $(MAKE) --no-print-directory

clean: 
	(rm -r ${BUILD_DIR} 2>/dev/null) || exit 0 

# инкрементальная сборка и запуск исполняемого файла 
run:
	cd ${BUILD_DIR} && $(MAKE) --no-print-directory
	${TARGET}

# выполняется, если исполняемый файл существует
test: ${TARGET}
	./${BUILD_DIR}/${LIB}/tests/tests

# проверяет исходный код
check:
	chmod u+x ${PATH_LINTERS_SCRIPT} && ./${PATH_LINTERS_SCRIPT}