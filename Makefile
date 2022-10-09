# чувствителен к изменению исходных файлов
# игнорирует изменения файла CMakeLists.txt

LIB = fib_lib
BUILD_DIR = build
TARGET = ./${BUILD_DIR}/fib
TEST_OPT = OFF
DEBUG = ON

.PHONY: check build rebuild test run

build: clean
	mkdir ${BUILD_DIR}
	cd ${BUILD_DIR} && cmake .. -DTEST_OPT=${TEST_OPT} -DDEBUG=${DEBUG} && $(MAKE) --no-print-directory

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
	chmod u+x run_linters.sh
	./run_linters.sh
