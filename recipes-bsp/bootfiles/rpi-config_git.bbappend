do_deploy:append() {
    install -d ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}
    CONFIG=${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/config.txt

    # UART support on bootloader stage
    if [ "${UART_BOORLOADER}" = "1" ] || [ "${ENABLE_UART}" = "0" ]; then
        echo "# Enable UART on bootloader" >>$CONFIG
        echo "uart_2ndstage=${UART_BOORLOADER}" >>$CONFIG
    elif [ -n "${UART_BOORLOADER}" ]; then
        bbfatal "Invalid value for UART_BOORLOADER [${UART_BOORLOADER}]. The value for UART_BOORLOADER can be 0 or 1."
    fi
}
