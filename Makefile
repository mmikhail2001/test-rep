# чувствителен к изменению исходных файлов
# игнорирует изменения файла CMakeLists.txt (если make run)

LIB = fib_lib
BUILD_DIR = build
TARGET = ./${BUILD_DIR}/fib
TEST_OPT 		= OFF
DEBUG_OPT 		= ON
SANITIZE_OPT 	= OFF

.PHONY: check build rebuild test run

build: clean
	mkdir ${BUILD_DIR}
	cd ${BUILD_DIR} && cmake .. -DTEST_OPT=${TEST_OPT} -DDEBUG_OPT=${DEBUG_OPT} -DSANITIZE_OPT=${SANITIZE_OPT} && $(MAKE) --no-print-directory

clean: 
	(rm -r ${BUILD_DIR} 2>/dev/null) || exit 0 

# выполняется, если проект собран
run: ${TARGET}
	cd ${BUILD_DIR} && $(MAKE) --no-print-directory
	${TARGET}

# выполняется, если проект собран
test: ${TARGET}
	cd ${BUILD_DIR}/${LIB} && ctest

# проверяет исходный код
check:
	chmod u+x linters/run.sh && ./linters/run.sh

# chmod u+x run_linters.sh
# ./run_linters.sh
