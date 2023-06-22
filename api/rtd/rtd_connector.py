import oracledb

from configs.rtd_config import username, password, RTD


def connect_rtd():
    try:
        con = oracledb.connect(
            user=username,
            password=password,
            dsn=RTD,
        )

        cur = con.cursor()
        return con, cur

    except oracledb.DatabaseError as e:
        return None


def close_rtd(con, cur):
    cur.close()
    con.close()
