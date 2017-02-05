"""
YZYAML implements 'yaml' functionalities
"""

def main():
    """
    MAIN function
    """

    print('Hello, World!')

class YZYaml(object):
    """
    YZYAML implements `yaml` functionalities
    """

    @staticmethod
    def dumps(obj, indent=4):
        """
        DUMPS converts object to the yaml-string

        Parameters
        ----------
        - obj: object
            input object
        - indent: int (default=4)
            size of indentation

        Returns
        -------
        - str
            returned yaml-string

        Examples
        --------
        1.
            >>> obj = {
                "Name": "BoBo",
                "Age": 30,
                "Married": True,
                "Children": [
                    {
                        "Name": "KoKo",
                        "Age": 5
                    },
                    {
                        "Name": "LoLo",
                        "Age": 3
                    }
                ],
                "Code": None
            }

        >>> yzyaml.YZYaml.dumps(obj)
        '''
            Name: BoBo
            Age: 30
            Married: True
            Children:
                - Name: KoKo
                Age: 5
                - Name: LoLo
                Age: 3
            Code:
        '''
        """

        delta_indent = ' ' * indent
        res = ['---\n']

        def rec_dumps(obj, spaces, nobreak):
            """
            REC_DUMPS converts object to the yaml-string

            Parameters
            ----------
            - obj: object
                input object
            - spaces: str
                spaces of indentation
            - nobreak: bool
                specifies that it should be used new-line or not

            Returns
            -------
            - str
                returned yaml-string
            """

            nonlocal res

            # object
            if isinstance(obj, dict):
                if not nobreak:
                    res.append('\n')

                first_item = True
                for key, value in obj.items():
                    if nobreak and first_item:
                        res.append('{}: '.format(key))
                        first_item = False
                    else:
                        res.append('{}{}: '.format(spaces, key))
                    rec_dumps(value, spaces + delta_indent, False)
            # array
            elif isinstance(obj, list):
                if not nobreak:
                    res.append('\n')

                first_item = True
                for item in obj:
                    if nobreak and first_item:
                        res.append('- ')
                        first_item = False
                    else:
                        res.append('{}- '.format(spaces))
                    rec_dumps(item, spaces + '  ', True)
            elif obj is None:
                res.append('\n')
            else:
                res.append('{}\n'.format(str(obj)))

        rec_dumps(obj, '', True)
        return ''.join(res)

if __name__ == "__main__":
    main()
