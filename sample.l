/*********************************************************************
 *  ������ϻ��� yylex() ���֤�����μ���(tag)�����
 *********************************************************************/

%{

#define INTEGER      1  /* �����򼨤� tag */
#define OPERATOR     2  /* �黻�Ҥ򼨤� tag */
#define PARENTHESES  3  /* ��̤򼨤� tag */

%}

/*********************************************************************
 *  ʬ�व���������ɽ�� ( r(X) �� X ����ʬ�Τߵ��� )
 *********************************************************************/

integer     "0"|[1-9][0-9]*
operator    "+"|"-"|"*"|"/"
parentheses "("|")"

/*** ��1: [0-9] �� "0"|"1"|"2"|"3"|...|"8"|"9" �ξ�άɽ�� ***/

/*********************************************************************
 *  ������ϥ롼��
 *********************************************************************/

%%

{integer}     { return INTEGER; }      /* �����ʤ������� tag ���֤� */
{operator}    { return OPERATOR; }     /* �黻�Ҥʤ�黻�Ҥ� tag ���֤� */
{parentheses} { return PARENTHESES; }  /* ��̤ʤ��̤� tag ���֤� */
"\n"          { return 0; }            /* ���Ԥˤ�äƲ��Ͻ�λ */
[" ""\t"]+                             /* ����� TAB ���ɤ����Ф� */
.           { printf("Error: '%c'\n", yytext[0]); exit(1); }

%%

/*** ��2: X+ �� XX* �ξ�άɽ�� ***/
/*** ��3: . ��Ǥ�դΰ�ʸ���˥ޥå����� ***/

/*********************************************************************
 *  ������ϥᥤ��롼����
 *********************************************************************/

int main()
{
        int tag;          /* ��μ��� */
        int line_num = 0; /* ���ֹ� */

        while (tag = yylex()) {
                /*
                    yylex() �ϸ�μ�������ͤȤ���yytext ���ڤ�Ф��줿���
                    ������Ƥ롥
                */
                printf("[%2d] ", ++line_num);
                printf("tag = %2d, ", tag);
                printf("text = %s\n", yytext);
        }
        return 0;
}